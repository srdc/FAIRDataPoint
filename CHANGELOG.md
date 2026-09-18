# Changelog

- R7 spec: https://healthdataeu.pages.code.europa.eu/healthdcat-ap/releases/release-7/
- R7 changelog: https://healthdataeu.pages.code.europa.eu/healthdcat-ap/releases/release-7/changelog.html
- R6 changelog: https://healthdataeu.pages.code.europa.eu/healthdcat-ap/releases/release-6/changelog.html

## Added

- `healthdcatap:hasStructuredData` on `DatasetShape`. `shacl:minCount 1`, `shacl:maxCount 1`,
  `shacl:datatype xsd:boolean`, placed in the mandatory section with a `dash:BooleanSelectEditor`.
  Source: https://healthdataeu.pages.code.europa.eu/healthdcat-ap/releases/release-7/changelog.html
  (section "1. New Model Elements", subsection "1.1 Structured Data").

- `healthdcatap:hasVariables` on `DatasetShape`. `shacl:nodeKind shacl:IRI`, optional section.
  Not constrained with `shacl:class csvw:TableGroup`, because the target's `rdf:type` is held in a
  separate named graph.
  Source: https://healthdataeu.pages.code.europa.eu/healthdcat-ap/releases/release-7/#healthdcataphasVariables
  (Dataset property table, row "variables"), and
  https://healthdataeu.pages.code.europa.eu/healthdcat-ap/releases/release-7/changelog.html
  (subsection "1.2 Variables - Migration from Sample to Dataset").

- `CSVWTableGroup` metadata schema, targeting `dcat:Resource` and `csvw:TableGroup`:
  `:CSVWTableGroupShape` (`csvw:table` minCount 1), `:CSVWTableShape` (`csvw:column` minCount 1,
  `dct:title` minCount 1, `csvw:url` maxCount 1 IRI), `:CSVWColumnShape` (`csvw:name`,
  `csvw:titles` and `dct:description` each minCount 1, `csvw:datatype` exactly 1,
  `csvw:propertyUrl` maxCount 1 IRI).
  Source: https://healthdataeu.pages.code.europa.eu/healthdcat-ap/releases/release-7/
  (section 7 "Main Entities", classes "Table Group", "Table" and "Column").

- `:CPOVContactPointShape` targeting `cv:ContactPoint`, with `cv:email` as `shacl:Literal`,
  `cv:contactPage` as `shacl:IRI`, plus `cv:telephone`, `cv:openingHours` and
  `cv:specialOpeningHoursSpecification`.
  Source: https://semiceu.github.io/CPOV/releases/2.1.1/#ContactPoint (property table), and
  https://code.europa.eu/healthdataeu/healthdcat-ap/-/issues/25 for `cv:email` being a plain
  literal rather than a `mailto:` IRI.

- `:HDABShape`, `:PublisherShape` and `:CustodianShape`, each requiring `foaf:name` and exactly one
  `cv:contactPoint` resolved against `:CPOVContactPointShape`.
  Source: https://healthdataeu.pages.code.europa.eu/healthdcat-ap/releases/release-7/
  (section 7.1 "Agent", subsections "Health Data Access Body", "Publisher" and "Custodian";
  the contact point row is cardinality 1 in all three tables).

- `:AgentShape`, `:ChecksumShape`, `:ConceptShape`, `:ConceptSchemeShape`, `:IdentifierShape`,
  `:LicenseDocumentShape`, `:LocationShape`, `:PeriodOfTimeShape`, `:RelationshipShape` and
  `:ResourceShape`, covering the nested nodes referenced from the Dataset and Distribution shapes.
  Sources, each the matching class table:
  https://semiceu.github.io/DCAT-AP/releases/3.0.1#Concept.preferredlabel,
  https://semiceu.github.io/DCAT-AP/releases/3.0.1#ConceptScheme.title,
  https://semiceu.github.io/DCAT-AP/releases/3.0.1#Identifier.notation,
  https://semiceu.github.io/DCAT-AP/releases/3.0.1#LicenceDocument.type,
  https://semiceu.github.io/DCAT-AP/releases/3.0.1#Location.bbox,
  https://semiceu.github.io/DCAT-AP/releases/3.0.1#PeriodofTime.startdate,
  https://semiceu.github.io/DCAT-AP/releases/3.0.1#Relationship.hadrole.

- Optional property shapes for the health-specific Dataset properties, so they are editable in the
  form rather than passed through unseen: `minTypicalAge`, `maxTypicalAge`, `numberOfRecords`,
  `numberOfUniqueIndividuals`, `populationCoverage`, `retentionPeriod`, `adms:sample` and
  `healthdcatap:analytics`.
  Source: https://healthdataeu.pages.code.europa.eu/healthdcat-ap/releases/release-7/#healthdcatapminTypicalAge
  and the neighbouring rows of the same Dataset property table.

## Updated

- `dct:accessRights` on `DatasetShape` is now `shacl:minCount 1`, `shacl:maxCount 1` and restricted
  with `shacl:in` to the three access-right IRIs (`PUBLIC`, `NON_PUBLIC`, `RESTRICTED`), rendered
  with a `dash:EnumSelectEditor`.
  Source: https://semiceu.github.io/DCAT-AP/releases/3.0.1#Dataset.accessrights (cardinality), and
  https://healthdataeu.pages.code.europa.eu/healthdcat-ap/releases/release-7/
  (section 10.3.1, row `dct:accessRights`, which names the Access Rights NAL and the three codes).

- `dct:identifier` on `DatasetShape` is `shacl:nodeKind shacl:Literal` with no datatype pinned.
  The previous `xsd:anyURI` excluded the plain string used in the specification's own example.
  Source: https://semiceu.github.io/DCAT-AP/releases/3.0.1#Dataset.identifier, and
  https://healthdataeu.pages.code.europa.eu/healthdcat-ap/releases/release-7/
  (Dataset property table, row "identifier", range Literal).

- `dct:publisher` on `CatalogShape` is now `shacl:minCount 1` and `shacl:maxCount 1`.
  Source: https://code.europa.eu/healthdataeu/healthdcat-ap/-/issues/27, and
  https://healthdataeu.pages.code.europa.eu/healthdcat-ap/releases/release-7/
  (Catalogue property table, row "publisher", cardinality 1..1).

- Publisher note and publisher type are held on the Publisher agent as `dc:description` and
  `dc:type`. `healthdcatap:publisherNote` and `healthdcatap:publisherType` are not referenced.
  Source: https://healthdataeu.pages.code.europa.eu/healthdcat-ap/releases/release-7/
  (section 7.1 "Agent", subsection "Publisher", rows "description" and "type"; the type row names
  the NAL Health Publisher Types (EHDS) as mandatory).

- `healthdcatap:hasCodeValues` is `shacl:nodeKind shacl:Literal` with no language tag enforced.
  Source: https://healthdataeu.pages.code.europa.eu/healthdcat-ap/releases/release-6/changelog.html
  (bullet "Migrating the healthdcatap:hasCodeValues from wikidata to free text"), and
  https://code.europa.eu/healthdataeu/healthdcat-ap/-/issues/26 for the language tag.

- Dataset properties are split across `:DatasetMandatorySection` and `:DatasetOptionalSection`, so
  the form separates the eight properties mandatory in the public layer from the rest.
  Source: https://healthdataeu.pages.code.europa.eu/healthdcat-ap/releases/release-7/context/healthdcat-cardinality-rules.json
  (the `PUBLIC` block, entries whose `requirement` is `Mandatory`).

## Removed

- The `dcat:contactPoint` vCard fields on `:HDABShape` and `:PublisherShape`. Agent contact details
  are held only as `cv:contactPoint`. `:ContactPointShape` itself is retained, because the Dataset
  and Distribution shapes still use `vcard:Kind` for their own `dcat:contactPoint`.
  Source: https://healthdataeu.pages.code.europa.eu/healthdcat-ap/releases/release-6/changelog.html
  (bullet "Contact point Migration of Dataset Publisher, HDAB and custodian from DCTERMS to CPOV"),
  and the Agent subsection tables of
  https://healthdataeu.pages.code.europa.eu/healthdcat-ap/releases/release-7/, which list
  `cv:contactPoint` only.
