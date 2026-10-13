/**
 * The MIT License
 * Copyright © 2016-2024 FAIR Data Team
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package org.fairdatapoint.util;

import com.ibm.icu.text.Collator;
import com.ibm.icu.text.RuleBasedCollator;
import com.ibm.icu.util.ULocale;
import org.eclipse.rdf4j.model.IRI;
import org.eclipse.rdf4j.model.Model;
import org.eclipse.rdf4j.model.Resource;
import org.eclipse.rdf4j.model.Statement;
import org.eclipse.rdf4j.model.Value;
import org.eclipse.rdf4j.model.impl.LinkedHashModel;

import java.util.ArrayDeque;
import java.util.Comparator;
import java.util.Deque;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;
import java.util.Set;

import static org.fairdatapoint.util.ValueFactoryHelper.i;

/**
 * Pages the variables (csvw:column) of a CSVW Table Group
 */
public final class CsvwPageUtil {

    public static final IRI CSVW_COLUMN = i("http://www.w3.org/ns/csvw#column");

    public static final IRI CSVW_NAME = i("http://www.w3.org/ns/csvw#name");

    public static final String SORT_NAME = "name";

    private static final IRI CSVW_BASE = i("http://www.w3.org/ns/csvw#base");

    private static final Map<String, List<IRI>> SORT_PREDICATES = Map.of(
            SORT_NAME, List.of(CSVW_NAME),
            "title", List.of(i("http://www.w3.org/ns/csvw#titles"), i("http://www.w3.org/ns/csvw#title")),
            "description", List.of(i("http://purl.org/dc/terms/description")),
            "datatype", List.of(i("http://www.w3.org/ns/csvw#datatype")),
            "propertyUrl", List.of(i("http://www.w3.org/ns/csvw#propertyUrl"))
    );

    private static final Comparator<String> NATURAL_ORDER = naturalOrder();

    private CsvwPageUtil() {
    }

    private static Comparator<String> naturalOrder() {
        final RuleBasedCollator collator = (RuleBasedCollator) Collator.getInstance(ULocale.ENGLISH);
        collator.setNumericCollation(true);
        collator.setStrength(Collator.SECONDARY);
        collator.freeze();
        return collator::compare;
    }

    public static boolean isSortKey(String key) {
        return SORT_PREDICATES.containsKey(key);
    }

    public static List<Resource> getColumns(Model model) {
        return getColumns(model, SORT_NAME, false);
    }

    public static List<Resource> getColumns(Model model, String sortKey, boolean descending) {
        final List<IRI> predicates = SORT_PREDICATES.getOrDefault(sortKey, SORT_PREDICATES.get(SORT_NAME));
        final Comparator<Resource> byKey = (col1, col2) -> {
            final Optional<String> key1 = sortValue(model, col1, predicates);
            final Optional<String> key2 = sortValue(model, col2, predicates);
            if (key1.isEmpty() || key2.isEmpty()) {
                return Boolean.compare(key1.isEmpty(), key2.isEmpty());
            }
            final int result = NATURAL_ORDER.compare(key1.get(), key2.get());
            return descending ? -result : result;
        };
        final List<IRI> namePredicates = SORT_PREDICATES.get(SORT_NAME);
        final Comparator<Resource> byName = Comparator.comparing(
                (Resource column) -> sortValue(model, column, namePredicates).orElse(""),
                NATURAL_ORDER
        );
        return model
                .filter(null, CSVW_COLUMN, null)
                .objects()
                .stream()
                .filter(Value::isResource)
                .map(Resource.class::cast)
                .distinct()
                .sorted(byKey.thenComparing(byName).thenComparing(Resource::stringValue))
                .toList();
    }

    private static Optional<String> sortValue(Model model, Resource column, List<IRI> predicates) {
        return predicates
                .stream()
                .flatMap(predicate -> model.filter(column, predicate, null).objects().stream())
                .map(value -> {
                    if (value.isBNode()) {
                        return model.filter((Resource) value, CSVW_BASE, null).objects().stream()
                                .findFirst().map(Value::stringValue).orElse(null);
                    }
                    return value.stringValue();
                })
                .filter(Objects::nonNull)
                .min(NATURAL_ORDER);
    }

    public static Model page(Model model, Resource entity, List<Resource> columns, int page, int size) {
        final Set<Resource> allColumns = new HashSet<>(columns);
        final List<Resource> pageList = columns.stream().skip((long) page * size).limit(size).toList();
        final Set<Resource> pageColumns = new HashSet<>(pageList);

        final Set<Resource> base = reach(model, Set.of(entity), Set.of());
        final Set<Resource> fromColumns = reach(model, allColumns, base);
        final Set<Resource> fromPage = reach(model, pageColumns, base);

        final Model result = new LinkedHashModel();
        model.getNamespaces().forEach(result::setNamespace);
        for (Statement st : model) {
            final Resource subject = st.getSubject();
            if (CSVW_COLUMN.equals(st.getPredicate())) {
                continue;
            }
            if (base.contains(subject) || fromPage.contains(subject) || !fromColumns.contains(subject)) {
                result.add(st);
            }
        }
        for (Resource column : pageList) {
            result.addAll(model.filter(null, CSVW_COLUMN, column));
        }
        return result;
    }

    private static Set<Resource> reach(Model model, Set<Resource> roots, Set<Resource> stop) {
        final Set<Resource> visited = new HashSet<>();
        final Deque<Resource> queue = new ArrayDeque<>(roots);
        while (!queue.isEmpty()) {
            final Resource current = queue.pop();
            if (stop.contains(current) || !visited.add(current)) {
                continue;
            }
            for (Statement st : model.filter(current, null, null)) {
                if (CSVW_COLUMN.equals(st.getPredicate())) {
                    continue;
                }
                if (st.getObject().isResource()) {
                    queue.push((Resource) st.getObject());
                }
            }
        }
        return visited;
    }
}
