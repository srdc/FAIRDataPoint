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
package org.fairdatapoint.api.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.eclipse.rdf4j.model.IRI;
import org.eclipse.rdf4j.model.Model;
import org.eclipse.rdf4j.model.Resource;
import org.fairdatapoint.database.rdf.repository.RepositoryMode;
import org.fairdatapoint.entity.resource.ResourceDefinition;
import org.fairdatapoint.entity.user.UserAccount;
import org.fairdatapoint.service.metadata.common.MetadataService;
import org.fairdatapoint.service.metadata.enhance.MetadataEnhancer;
import org.fairdatapoint.service.metadata.exception.MetadataServiceException;
import org.fairdatapoint.service.metadata.factory.MetadataServiceFactory;
import org.fairdatapoint.service.resource.ResourceDefinitionService;
import org.fairdatapoint.service.user.CurrentUserService;
import org.fairdatapoint.util.CsvwPageUtil;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.LinkedList;
import java.util.List;
import java.util.Optional;

import static java.lang.String.format;
import static org.fairdatapoint.util.HttpUtil.getMetadataIRI;

/**
 * Serves a CSVW Table Group with its variables (csvw:column) split into pages
 */
@Tag(name = "Metadata")
@RestController
@RequiredArgsConstructor
public class CsvwContentController {

    public static final String TOTAL_COUNT_HEADER = "X-Total-Count";

    private static final int MAX_PAGE_SIZE = 1000;

    private final String persistentUrl;

    private final MetadataServiceFactory metadataServiceFactory;

    private final ResourceDefinitionService resourceDefinitionService;

    private final MetadataEnhancer metadataEnhancer;

    private final CurrentUserService currentUserService;

    @Operation(hidden = true)
    @GetMapping(path = "{urlPrefix:[^.]+}/{recordId:[^.]+}/content", produces = "!application/json")
    public ResponseEntity<Model> getContentPage(
            @PathVariable final String urlPrefix,
            @PathVariable final String recordId,
            @RequestParam(defaultValue = "0") final int page,
            @RequestParam(defaultValue = "25") final int size,
            @RequestParam(defaultValue = CsvwPageUtil.SORT_NAME) final String sort,
            @RequestParam(defaultValue = "asc") final String order
    ) throws MetadataServiceException {
        final int pageSize = Math.max(1, Math.min(size, MAX_PAGE_SIZE));
        final int pageNumber = Math.max(0, page);
        final String sortKey = CsvwPageUtil.isSortKey(sort) ? sort : CsvwPageUtil.SORT_NAME;
        final boolean descending = "desc".equalsIgnoreCase(order);

        // Get entity
        final MetadataService metadataService = metadataServiceFactory.getMetadataServiceByUrlPrefix(urlPrefix);
        final ResourceDefinition rd = resourceDefinitionService.getByUrlPrefix(urlPrefix);
        final Optional<UserAccount> oCurrentUser = currentUserService.getCurrentUser();
        final IRI entityUri = getMetadataIRI(persistentUrl, urlPrefix, recordId);
        final RepositoryMode mode = oCurrentUser.isEmpty() ? RepositoryMode.MAIN : RepositoryMode.COMBINED;
        final Model entity = metadataService.retrieve(entityUri, mode);

        // Keep only the requested page of columns
        final List<Resource> columns = CsvwPageUtil.getColumns(entity, sortKey, descending);
        final Model resultRdf = CsvwPageUtil.page(entity, entityUri, columns, pageNumber, pageSize);

        // Add links
        metadataEnhancer.enhanceWithLinks(entityUri, entity, rd, persistentUrl, resultRdf);
        metadataEnhancer.enhanceWithResourceDefinition(entityUri, rd, resultRdf);

        // Paging headers
        final HttpHeaders headers = new HttpHeaders();
        headers.set(TOTAL_COUNT_HEADER, String.valueOf(columns.size()));
        final String query = format("size=%d&sort=%s&order=%s", pageSize, sortKey, descending ? "desc" : "asc");
        final String entityUrl = entityUri.stringValue();
        headers.set(HttpHeaders.LINK, createLinkHeader(entityUrl, columns.size(), pageNumber, pageSize, query));
        return ResponseEntity.ok().headers(headers).body(resultRdf);
    }

    private String createLinkHeader(String entityUrl, int total, int page, int size, String query) {
        final List<String> links = new LinkedList<>();
        final int lastPage = Math.max(0, (int) Math.ceil((double) total / size) - 1);

        links.add(createLink(entityUrl, 0, query, "first"));
        links.add(createLink(entityUrl, lastPage, query, "last"));
        if (page > 0 && page <= lastPage) {
            links.add(createLink(entityUrl, page - 1, query, "prev"));
        }
        if (page < lastPage) {
            links.add(createLink(entityUrl, page + 1, query, "next"));
        }
        return String.join(", ", links);
    }

    private String createLink(String entityUrl, int page, String query, String rel) {
        return format("<%s/content?page=%d&%s>; rel=\"%s\"", entityUrl, page, query, rel);
    }
}
