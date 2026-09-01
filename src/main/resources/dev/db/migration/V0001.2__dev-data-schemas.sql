--
-- The MIT License
-- Copyright © 2016-2024 FAIR Data Team
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in
-- all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
-- THE SOFTWARE.
--


-- >>> File: resource.sql
-- Resource
INSERT INTO metadata_schema (uuid, created_at, updated_at)
VALUES ('ab3ce955-c4c5-4bbe-b295-501116d4301e', NOW(), NOW());
INSERT INTO metadata_schema_version (uuid, metadata_schema_id, previous_version_id, version, name, description,
                                     definition, target_classes, type, origin, imported_from, state, published,
                                     abstract, suggested_resource_name, suggested_url_prefix, created_at, updated_at)
VALUES ('ad9f1c05-ab5c-459d-aefa-c0a4f4be2d6f',
        'ab3ce955-c4c5-4bbe-b295-501116d4301e',
        NULL,
        '1.0.0',
        'Resource',
        '',
        '@prefix : <http://fairdatapoint.org/> .
@prefix dcat: <http://www.w3.org/ns/dcat#> .
@prefix shacl: <http://www.w3.org/ns/shacl#> .
@prefix dc: <http://purl.org/dc/terms/> .
@prefix foaf: <http://xmlns.com/foaf/0.1/> .
@prefix prov: <http://www.w3.org/ns/prov#> .
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix skos: <http://www.w3.org/2004/02/skos/core#> .
@prefix vcard: <http://www.w3.org/2006/vcard/ns#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .
@prefix dash:     <http://datashapes.org/dash#> .
@prefix time: <http://www.w3.org/2006/time#> .
@prefix healthdcatap: <http://healthdataportal.eu/ns/health#> .

:AgentShape a shacl:NodeShape;
  shacl:closed false;
  shacl:property [
    rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Agent.type";
    # shacl:class skos:Concept;
    shacl:description "The nature of the agent."@en;
    shacl:maxCount 1;
    shacl:name "type"@en;
    shacl:nodeKind shacl:BlankNodeOrIRI;
    dash:editor dash:URIEditor ;
    shacl:path dc:type
  ], [
    rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Agent.name";
    shacl:description "A name of the agent."@en;
    shacl:minCount 1;
    shacl:name "name"@en;
    shacl:path foaf:name ;
    shacl:nodeKind shacl:Literal;
    dash:editor dash:TextFieldEditor;
    dash:viewer dash:LiteralViewer
  ];
  shacl:targetClass foaf:Agent .

:ChecksumShape a shacl:NodeShape;
  shacl:closed false;
  shacl:property [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Checksum.checksumvalue";
      shacl:datatype xsd:hexBinary;
      shacl:minCount 1;
      shacl:maxCount 1;
      shacl:description "A lower case hexadecimal encoded digest value produced using a specific algorithm."@en;
      shacl:name "checksum value"@en;
      shacl:nodeKind shacl:Literal;
      dash:editor dash:TextFieldEditor;
      dash:viewer dash:LiteralViewer;
      shacl:path <http://spdx.org/rdf/terms#checksumValue>
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Checksum.algorithm";
      shacl:class <http://spdx.org/rdf/terms#ChecksumAlgorithm>;
      shacl:minCount 1;
      shacl:maxCount 1;
      shacl:description "The algorithm used to produce the subject Checksum."@en;
      shacl:name "algorithm"@en;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path <http://spdx.org/rdf/terms#algorithm>
    ];
  shacl:targetClass <http://spdx.org/rdf/terms#Checksum> .

:ConceptShape a shacl:NodeShape;
  shacl:closed false;
  shacl:property [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Concept.preferredlabel";
      shacl:minCount 1;
      shacl:description "A preferred label of the concept."@en;
      shacl:name "preferred label"@en;
      shacl:nodeKind shacl:Literal;
      dash:editor dash:TextFieldEditor;
      dash:viewer dash:LiteralViewer;
      shacl:path skos:prefLabel
    ];
  shacl:targetClass skos:Concept .

:ConceptSchemeShape a shacl:NodeShape;
  shacl:closed false;
  shacl:property [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#ConceptScheme.title";
      shacl:description "A name of the concept scheme."@en;
      shacl:name "title"@en;
      shacl:nodeKind shacl:Literal;
      dash:editor dash:TextFieldEditor;
      dash:viewer dash:LiteralViewer;
      shacl:path dc:title
    ], [
      shacl:description "A preferred label of the concept scheme."@en;
      shacl:name "pref label"@en;
      shacl:nodeKind shacl:Literal;
      dash:editor dash:TextFieldEditor;
      dash:viewer dash:LiteralViewer;
      shacl:path skos:prefLabel
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#ConceptScheme.title";
      shacl:description "A label of the concept scheme."@en;
      shacl:name "label"@en;
      shacl:nodeKind shacl:Literal;
      dash:editor dash:TextFieldEditor;
      dash:viewer dash:LiteralViewer;
      shacl:path rdfs:label
    ];
  shacl:targetClass skos:ConceptScheme .

:ContactPointShape
    a shacl:NodeShape ;
    shacl:targetClass vcard:Kind ;
    shacl:property [
        shacl:name "Page" ;
        shacl:path vcard:hasURL ;
        shacl:maxCount 1 ;
        dash:editor dash:URIEditor ;
        dash:viewer dash:LabelViewer ;
    ], [
        shacl:name "Email" ;
        shacl:path vcard:hasEmail ;
        shacl:maxCount 1 ;
        dash:editor dash:LiteralEditor ;
        dash:viewer dash:LiteralViewer ;
    ] .

:HDAB
  a rdfs:Class ;
  rdfs:subClassOf foaf:Agent .

:HDABShape a shacl:NodeShape ;
  shacl:targetClass :HDAB ;
  shacl:property [
        shacl:path foaf:name ;
        shacl:name "Name" ;
        shacl:datatype xsd:string ;
        shacl:minCount 1 ;
        shacl:nodeKind shacl:Literal;
        dash:editor dash:TextFieldEditor ;
        dash:viewer dash:LiteralViewer ;
    ], [
        shacl:path dcat:contactPoint ;
        shacl:name "Contact point" ;
        shacl:node :ContactPointShape ;
        shacl:minCount 1 ;
        shacl:maxCount 1 ;
        dash:editor dash:BlankNodeEditor ;
    ], [
        shacl:path dc:type ;
        shacl:name "Type" ;
        shacl:nodeKind shacl:BlankNodeOrIRI ;
        shacl:maxCount 1 ;
        dash:editor dash:URIEditor ;
        dash:viewer dash:LabelViewer ;
    ] .

:IdentifierShape a shacl:NodeShape;
  shacl:closed false;
  shacl:property [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Identifier.notation";
      shacl:description "A string that is an identifier in the context of the identifier scheme referenced by its datatype."@en;
      shacl:name "notation"@en;
      shacl:nodeKind shacl:Literal;
      shacl:minCount 1;
      shacl:maxCount 1;
      dash:editor dash:TextFieldEditor;
      dash:viewer dash:LiteralViewer;
      shacl:path skos:notation
    ];
  shacl:targetClass <http://www.w3.org/ns/adms#Identifier> .

:LicenseDocumentShape a shacl:NodeShape;
  shacl:closed false;
  shacl:property [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#LicenceDocument.type";
      # shacl:class skos:Concept;
      shacl:description "A type of licence, e.g. indicating ''public domain'' or ''royalties required''."@en;
      shacl:name "type"@en;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path dc:type
    ];
  shacl:targetClass dc:LicenseDocument .

:LocationShape a shacl:NodeShape;
  shacl:closed false;
  shacl:property [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Location.bbox";
      shacl:description "The geographic bounding box of a resource."@en;
      shacl:name "bbox"@en;
      shacl:maxCount 1;
      shacl:nodeKind shacl:Literal;
      dash:editor dash:TextFieldEditor;
      dash:viewer dash:LiteralViewer;
      shacl:path dcat:bbox
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Location.geometry";
      shacl:class <http://www.w3.org/ns/locn#Geometry>;
      shacl:description "The corresponding geometry for a resource."@en;
      shacl:name "geometry"@en;
      shacl:maxCount 1;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path <http://www.w3.org/ns/locn#geometry>
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Location.centroid";
      shacl:description "The geographic center (centroid) of a resource."@en;
      shacl:name "centroid"@en;
      shacl:maxCount 1;
      shacl:nodeKind shacl:Literal;
      dash:editor dash:TextFieldEditor;
      dash:viewer dash:LiteralViewer;
      shacl:path dcat:centroid
    ];
  shacl:targetClass dc:Location .

:PeriodOfTimeShape a shacl:NodeShape;
  shacl:closed false;
  shacl:property [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#PeriodofTime.beginning";
      shacl:class <http://www.w3.org/2006/time#Instant>;
      shacl:description "The beginning of a period or interval."@en;
      shacl:name "beginning"@en;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      shacl:maxCount 1;
      dash:editor dash:BlankNodeEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path time:hasBeginning
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#PeriodofTime.end";
      shacl:class <http://www.w3.org/2006/time#Instant>;
      shacl:description "The end of a period or interval."@en;
      shacl:name "end"@en;
      shacl:maxCount 1;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:BlankNoteEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path time:hasEnd
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#PeriodofTime.startdate";
      shacl:description "The start of the period."@en;
      shacl:name "start date"@en;
      shacl:maxCount 1;
      shacl:datatype xsd:date;
      shacl:nodeKind shacl:Literal;
      dash:editor dash:DatePickerEditor;
      dash:viewer dash:LiteralViewer;
      shacl:path dcat:startDate
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#PeriodofTime.enddate";
      shacl:description "The end of the period."@en;
      shacl:name "end date"@en;
      shacl:maxCount 1;
      shacl:datatype xsd:date;
      shacl:nodeKind shacl:Literal;
      dash:editor dash:DatePickerEditor;
      dash:viewer dash:LiteralViewer;
      shacl:path dcat:endDate
    ];
  shacl:targetClass dc:PeriodOfTime .

:Publisher
  a rdfs:Class ;
  rdfs:subClassOf foaf:Agent .

:PublisherShape a shacl:NodeShape;
  shacl:closed false;
  shacl:targetClass :Publisher ;
  shacl:property [
    shacl:path foaf:name ;
    shacl:name "Publisher name"@en ;
    shacl:minCount 1 ;
    shacl:nodeKind shacl:Literal ;
    dash:editor dash:TextFieldEditor ;
    dash:viewer dash:LiteralViewer ;
  ], [
    shacl:path dc:description ;
    shacl:name "Publisher Note"@en ;
    shacl:nodeKind shacl:Literal ;
    shacl:maxCount 1 ;
    dash:editor dash:TextAreaEditor ;
    dash:viewer dash:LiteralViewer ;
  ], [
    shacl:path healthdcatap:trustedDataHolder ;
    shacl:name "Trusted data holder"@en ;
    shacl:datatype xsd:boolean ;
    shacl:maxCount 1 ;
    dash:editor dash:BooleanSelectEditor ;
    dash:viewer dash:LiteralViewer ;
  ], [
    shacl:path dc:type ;
    shacl:name "Publisher type"@en ;
    shacl:maxCount 1 ;
    shacl:nodeKind shacl:IRI ;
    dash:editor dash:URIEditor ;
    dash:viewer dash:LabelViewer ;
  ], [
    shacl:path dcat:contactPoint ;
    shacl:name "Contact point"@en ;
    shacl:minCount 1 ;
    shacl:maxCount 1 ;
    shacl:node :ContactPointShape ;
    dash:editor dash:BlankNodeEditor ;
    dash:viewer dash:DetailsViewer ;
  ].

:RelationshipShape a shacl:NodeShape;
      shacl:closed false;
      shacl:property [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Relationship.relation";
      shacl:description "A resource related to the source resource."@en;
      shacl:name "relation"@en;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      shacl:minCount 1;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path dc:relation ;
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Relationship.hadrole";
      shacl:class dcat:Role;
      shacl:description "A function of an entity or agent with respect to another entity or resource."@en;
      shacl:name "had role"@en;
      shacl:minCount 1;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path dcat:hadRole ;
    ];
  shacl:targetClass dcat:Relationship .

:ResourceShape a shacl:NodeShape;
  shacl:closed false;
  shacl:targetClass dcat:Resource .
',
        ARRAY ['http://www.w3.org/ns/dcat#Resource'],
        'INTERNAL',
        NULL,
        NULL,
        'LATEST',
        FALSE,
        TRUE,
        NULL,
        NULL,
        NOW(),
        NOW());
-- <<< End of: resource.sql

-- >>> File: catalog.sql
-- Catalog
INSERT INTO metadata_schema (uuid, created_at, updated_at)
VALUES ('998eac9d-8349-4aaa-a959-3a7341c558a2', NOW(), NOW());
INSERT INTO metadata_schema_version (uuid, metadata_schema_id, previous_version_id, version, name, description,
                                     definition, target_classes, type, origin, imported_from, state, published,
                                     abstract, suggested_resource_name, suggested_url_prefix, created_at, updated_at)
VALUES ('7201ccdb-8eb7-4003-a563-476e9eccebce',
        '998eac9d-8349-4aaa-a959-3a7341c558a2',
        NULL,
        '1.0.0',
        'Catalog',
        '',
        '@prefix : <http://fairdatapoint.org/> .
@prefix dc: <http://purl.org/dc/terms/> .
@prefix dcat: <http://www.w3.org/ns/dcat#> .
@prefix foaf: <http://xmlns.com/foaf/0.1/> .
@prefix prov: <http://www.w3.org/ns/prov#> .
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix shacl: <http://www.w3.org/ns/shacl#> .
@prefix skos: <http://www.w3.org/2004/02/skos/core#> .
@prefix vcard: <http://www.w3.org/2006/vcard/ns#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .
@prefix dash:     <http://datashapes.org/dash#> .
@prefix time: <http://www.w3.org/2006/time#> .

:CatalogShape a shacl:NodeShape;
  shacl:closed false;
  shacl:property [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Catalogue.geographicalcoverage";
      shacl:class dc:Location;
      shacl:description "A geographical area covered by the Catalogue."@en;
      shacl:name "geographical coverage"@en;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:BlankNodeEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:group :CatalogCoverageSection;
      shacl:order 1 ;
      shacl:path dc:spatial
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Catalogue.haspart";
      shacl:description "A related Catalogue that is part of the described Catalogue."@en;
      shacl:name "has part"@en;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:order 1 ;
      shacl:group :CatalogRelationsSection;
      shacl:path dc:hasPart
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Catalogue.themes";
      shacl:class skos:ConceptScheme;
      shacl:description "A knowledge organization system used to classify the Resources that are in the Catalogue."@en;
      shacl:name "themes"@en;
      shacl:node :ConceptSchemeShape;
      dash:editor dash:BlankNodeEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:order 2 ;
      shacl:group :CatalogCoverageSection;
      shacl:path dcat:themeTaxonomy
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Catalogue.applicablelegislation";
      shacl:class <http://data.europa.eu/eli/ontology#LegalResource>;
      shacl:minCount 1;
      shacl:description "The legislation that mandates the creation or management of the Catalogue."@en;
      shacl:name "applicable legislation"@en;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:group :CatalogMandatorySection;
      shacl:order 3 ;
      shacl:path <http://data.europa.eu/r5r/applicableLegislation>
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Catalogue.language";
      shacl:class dc:LinguisticSystem;
      shacl:description "A language used in the textual metadata describing titles, descriptions, etc. of the Datasets in the Catalogue."@en;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:BlankNodeEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:name "language"@en;
      shacl:order 3 ;
      shacl:group :CatalogCoverageSection;
      shacl:path dc:language
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Catalogue.record";
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:description "A Catalogue Record that is part of the Catalogue."@en;
      shacl:name "record"@en;
      shacl:order 3 ;
      shacl:group :CatalogRelationsSection;
      shacl:path dcat:record
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Catalogue.catalogue";
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:description "A catalogue whose contents are of interest in the context of this catalogue."@en;
      shacl:name "catalogue"@en;
      shacl:order 4 ;
      shacl:group :CatalogRelationsSection;
      shacl:path dcat:catalog
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Catalogue.releasedate";
      shacl:description "The date of formal issuance (e.g., publication) of the Catalogue."@en;
      shacl:name "release date"@en;
      shacl:maxCount 1;
      shacl:nodeKind shacl:Literal;
      dash:editor dash:DateTimePickerEditor;
      dash:viewer dash:LiteralViewer;
      shacl:order 4 ;
      shacl:group :CatalogPublicationSection;
      shacl:path dc:issued
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Catalogue.publisher";
      shacl:description "An entity (organisation) responsible for making the Catalogue available."@en;
      shacl:class foaf:Agent;
      shacl:node :AgentShape;
      shacl:maxCount 1;
      dash:editor dash:BlankNodeEditor ;
      dash:viewer dash:DetailsViewer ;
      shacl:name "publisher"@en;
      shacl:group :CatalogPublicationSection;
      shacl:order 1 ;
      shacl:path dc:publisher
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Catalogue.modificationdate";
      shacl:description "The most recent date on which the Catalogue was modified."@en;
      shacl:name "modification date"@en;
      shacl:maxCount 1;
      shacl:nodeKind shacl:Literal;
      dash:editor dash:DateTimePickerEditor;
      dash:viewer dash:LiteralViewer;
      shacl:order 5 ;
      shacl:group :CatalogPublicationSection;
      shacl:path dc:modified
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Catalogue.description";
      shacl:description "A free-text account of the Catalogue."@en;
      shacl:name "description"@en;
      shacl:minCount 1;
      shacl:nodeKind shacl:Literal;
      dash:editor dash:TextFieldEditor;
      dash:viewer dash:LiteralViewer;
      shacl:group :CatalogMandatorySection;
      shacl:order 2;
      shacl:path dc:description
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Catalogue.creator";
      shacl:class foaf:Agent;
      shacl:description "An entity responsible for the creation of the catalogue."@en;
      shacl:name "creator"@en;
      shacl:maxCount 1;
      shacl:node :AgentShape;
      dash:editor dash:BlankNodeEditor ;
      dash:viewer dash:DetailsViewer ;
      shacl:order 3 ;
      shacl:group :CatalogPublicationSection;
      shacl:path dc:creator
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Catalogue.temporalcoverage";
      shacl:class dc:PeriodOfTime;
      shacl:description "A temporal period that the Catalogue covers. Either Beginning/End or Start Date/End Date should be used."@en;
      shacl:name "temporal coverage"@en;
      shacl:node :PeriodOfTimeShape;
      dash:editor dash:BlankNodeEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:order 4 ;
      shacl:group :CatalogCoverageSection;
      shacl:path dc:temporal
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Catalogue.homepage";
      shacl:class foaf:Document;
      shacl:maxCount 1;
      shacl:description "A web page that acts as the main page for the Catalogue."@en;
      shacl:name "homepage"@en;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:order 6 ;
      shacl:group :CatalogPublicationSection;
      shacl:path foaf:homepage
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Catalogue.rights";
      shacl:class dc:RightsStatement;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:BlankNodeEditor ;
      dash:viewer dash:DetailsViewer ;
      shacl:description "A statement that specifies rights associated with the Catalogue."@en;
      shacl:name "rights"@en;
      shacl:order 7 ;
      shacl:group :CatalogPublicationSection;
      shacl:path dc:rights
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Catalogue.licence";
      shacl:class dc:LicenseDocument;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      shacl:description "A licence under which the Catalogue can be used or reused."@en;
      dash:editor dash:BlankNodeEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:maxCount 1;
      shacl:name "licence"@en;
      shacl:order 2 ;
      shacl:group :CatalogPublicationSection;
      shacl:path dc:license
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Catalogue.service";
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:description "A site or end-point (Data Service) that is listed in the Catalogue."@en;
      shacl:name "service"@en;
      shacl:order 5 ;
      shacl:group :CatalogRelationsSection;
      shacl:path dcat:service
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Catalogue.title";
      shacl:description "A name given to the Catalogue."@en;
      shacl:name "title"@en;
      shacl:minCount 1;
      shacl:nodeKind shacl:Literal;
      dash:editor dash:LiteralEditor;
      dash:viewer dash:LiteralViewer;
      shacl:group :CatalogMandatorySection;
      shacl:order 1;
      shacl:path dc:title
    ];
  shacl:targetClass dcat:Catalog .

:CatalogMandatorySection
  rdfs:label "Mandatory" ;
  rdfs:comment "Contains the essential catalog metadata required for identification and minimal compliance with DCAT-AP and HealthDCAT-AP." ;
  shacl:order 1 .

:CatalogCoverageSection
  rdfs:label "Coverage" ;
  rdfs:comment "Describes the thematic, geographic, temporal, and domain-specific scope of the catalog and the resources it includes." ;
  shacl:order 2 .

:CatalogPublicationSection
  rdfs:label "Publication" ;
  rdfs:comment "Provides information related to the catalog’s publication lifecycle, including release dates, update dates, and other administrative metadata." ;
  shacl:order 3 .

:CatalogContactSection
  rdfs:label "Contact" ;
  rdfs:comment "Specifies responsible organizations or individuals and their contact information for inquiries, support, or governance matters." ;
  shacl:order 4 .

:CatalogRelationsSection
  rdfs:label "Relations" ;
  rdfs:comment "Lists links to related resources such as datasets, data services, subcatalogs, and catalog records, defining the catalog’s structural and semantic relationships." ;
  shacl:order 5 .
',
        ARRAY ['http://www.w3.org/ns/dcat#Resource', 'http://www.w3.org/ns/dcat#Catalog'],
        'INTERNAL',
        NULL,
        NULL,
        'LATEST',
        FALSE,
        FALSE,
        NULL,
        NULL,
        NOW(),
        NOW());
INSERT INTO metadata_schema_extension (uuid, metadata_schema_version_id, extended_metadata_schema_id, order_priority) VALUES ('f23a1330-1b3e-40b2-9d49-bde35b538751', '7201ccdb-8eb7-4003-a563-476e9eccebce', 'ab3ce955-c4c5-4bbe-b295-501116d4301e', 0);
-- <<< End of: catalog.sql


-- >>> File: catalogrecord.sql
-- CatalogRecord
INSERT INTO metadata_schema (uuid, created_at, updated_at)
VALUES ('f2c47743-ae29-4a0a-9d39-d67e45c344ff', NOW(), NOW());
INSERT INTO metadata_schema_version (uuid, metadata_schema_id, previous_version_id, version, name, description,
                                     definition, target_classes, type, origin, imported_from, state, published,
                                     abstract, suggested_resource_name, suggested_url_prefix, created_at, updated_at)
VALUES ('8d4a22ac-2627-405b-97e0-c19e6aafb785',
        'f2c47743-ae29-4a0a-9d39-d67e45c344ff',
        NULL,
        '1.0.0',
        'CatalogRecord',
        '',
        '@prefix : <http://fairdatapoint.org/> .
@prefix dc: <http://purl.org/dc/terms/> .
@prefix dcat: <http://www.w3.org/ns/dcat#> .
@prefix foaf: <http://xmlns.com/foaf/0.1/> .
@prefix prov: <http://www.w3.org/ns/prov#> .
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix shacl: <http://www.w3.org/ns/shacl#> .
@prefix skos: <http://www.w3.org/2004/02/skos/core#> .
@prefix vcard: <http://www.w3.org/2006/vcard/ns#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .
@prefix dash:     <http://datashapes.org/dash#> .

:CatalogRecordShape a shacl:NodeShape;
  shacl:closed false;
  shacl:property [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#CatalogueRecord.modificationdate";
      shacl:description "The most recent date on which the Catalogue entry was changed or modified."@en;
      shacl:name "modification date"@en;
      shacl:nodeKind shacl:Literal;
      shacl:minCount 1;
      shacl:maxCount 1;
      dash:editor dash:TextFieldEditor;
      dash:viewer dash:LiteralViewer;
      shacl:path dc:modified
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#CatalogueRecord.changetype";
      # shacl:class skos:Concept;
      shacl:description "The status of the catalogue record in the context of editorial flow of the dataset and data service descriptions."@en;
      shacl:name "change type"@en;
      shacl:maxCount 1;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path <http://www.w3.org/ns/adms#status>
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#CatalogueRecord.language";
      shacl:class dc:LinguisticSystem;
      shacl:description "A language used in the textual metadata describing titles, descriptions, etc. of the Catalogued Resource."@en;
      shacl:name "language"@en;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path dc:language
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#CatalogueRecord.applicationprofile";
      shacl:class dc:Standard;
      shacl:description "An Application Profile that the Catalogued Resource&#39;s metadata conforms to."@en;
      shacl:name "application profile"@en;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      shacl:path dc:conformsTo
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#CatalogueRecord.primarytopic";
      shacl:class dcat:Resource;
      shacl:description "A link to the Dataset, Data service or Catalog described in the record."@en;
      shacl:name "primary topic"@en;
      shacl:maxCount 1;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      shacl:minCount 1;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path foaf:primaryTopic
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#CatalogueRecord.sourcemetadata";
      shacl:class dcat:CatalogRecord;
      shacl:description "The original metadata that was used in creating metadata for the Dataset, Data Service or Dataset Series."@en;
      shacl:name "source metadata"@en;
      shacl:maxCount 1;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path dc:source
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#CatalogueRecord.listingdate";
      shacl:description "The date on which the description of the Resource was included in the Catalogue."@en;
      shacl:name "listing date"@en;
      shacl:maxCount 1;
      shacl:nodeKind shacl:Literal;
      dash:editor dash:TextFieldEditor;
      dash:viewer dash:LiteralViewer;
      shacl:path dc:issued
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#CatalogueRecord.description";
      shacl:description "A free-text account of the record. This property can be repeated for parallel language versions of the description."@en;
      shacl:name "description"@en;
      shacl:nodeKind shacl:Literal;
      dash:editor dash:TextFieldEditor;
      dash:viewer dash:LiteralViewer;
      shacl:path dc:description
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#CatalogueRecord.title";
      shacl:description "A name given to the Catalogue Record."@en;
      shacl:name "title"@en;
      shacl:nodeKind shacl:Literal;
      dash:editor dash:TextFieldEditor;
      dash:viewer dash:LiteralViewer;
      shacl:path dc:title
    ];
  shacl:targetClass dcat:CatalogRecord .
',
        ARRAY ['http://www.w3.org/ns/dcat#Resource', 'http://www.w3.org/ns/dcat#CatalogRecord'],
        'INTERNAL',
        NULL,
        NULL,
        'LATEST',
        FALSE,
        FALSE,
        NULL,
        NULL,
        NOW(),
        NOW());
INSERT INTO metadata_schema_extension (uuid, metadata_schema_version_id, extended_metadata_schema_id, order_priority) VALUES ('17020caf-3c29-4b9f-9a3d-8aa564f45762', '8d4a22ac-2627-405b-97e0-c19e6aafb785', 'ab3ce955-c4c5-4bbe-b295-501116d4301e', 0);
-- <<< End of: catalogrecord.sql

-- >>> File: dataservice.sql
-- DataService
INSERT INTO metadata_schema (uuid, created_at, updated_at)
VALUES ('a5259600-a7a1-4d1c-b3bd-77a9a7a64d2c', NOW(), NOW());
INSERT INTO metadata_schema_version (uuid, metadata_schema_id, previous_version_id, version, name, description,
                                     definition, target_classes, type, origin, imported_from, state, published,
                                     abstract, suggested_resource_name, suggested_url_prefix, created_at, updated_at)
VALUES ('45070030-30c1-4a56-a0a3-4ac273949496',
        'a5259600-a7a1-4d1c-b3bd-77a9a7a64d2c',
        NULL,
        '1.0.0',
        'DataService',
        '',
        '@prefix : <http://fairdatapoint.org/> .
@prefix dc: <http://purl.org/dc/terms/> .
@prefix dcat: <http://www.w3.org/ns/dcat#> .
@prefix foaf: <http://xmlns.com/foaf/0.1/> .
@prefix prov: <http://www.w3.org/ns/prov#> .
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix shacl: <http://www.w3.org/ns/shacl#> .
@prefix skos: <http://www.w3.org/2004/02/skos/core#> .
@prefix vcard: <http://www.w3.org/2006/vcard/ns#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .
@prefix dash:     <http://datashapes.org/dash#> .

:DataServiceShape a shacl:NodeShape;
  shacl:closed false;
  shacl:property [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#DataService.conformsto";
      shacl:class dc:Standard;
      shacl:description "An established (technical) standard to which the Data Service conforms."@en;
      shacl:name "conforms to"@en;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      shacl:path dc:conformsTo
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#DataService.applicablelegislation";
      shacl:class <http://data.europa.eu/eli/ontology#LegalResource>;
      shacl:description "The legislation that mandates the creation or management of the Data Service."@en;
      shacl:name "applicable legislation"@en;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path <http://data.europa.eu/r5r/applicableLegislation>
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#DataService.accessrights";
      shacl:class dc:RightsStatement;
      shacl:maxCount 1;
      shacl:description "Information regarding access or restrictions based on privacy, security, or other policies."@en;
      shacl:name "access rights"@en;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path dc:accessRights
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#DataService.servesdataset";
      shacl:class dcat:Dataset;
      shacl:description "This property refers to a collection of data that this data service can distribute."@en;
      shacl:name "serves dataset"@en;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path dcat:servesDataset
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#DataService.landingpage";
      shacl:class foaf:Document;
      shacl:description "A web page that provides access to the Data Service and/or additional information."@en;
      shacl:name "landing page"@en;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path dcat:landingPage
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#DataService.endpointURL";
      shacl:description "The root location or primary endpoint of the service (an IRI)."@en;
      shacl:name "endpoint URL"@en;
      shacl:minCount 1;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path dcat:endpointURL
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#DataService.keyword";
      shacl:description "A keyword or tag describing the Data Service."@en;
      shacl:name "keyword"@en;
      shacl:nodeKind shacl:Literal;
      dash:editor dash:TextFieldEditor;
      dash:viewer dash:LiteralViewer;
      shacl:path dcat:keyword
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#DataService.endpointdescription";
      shacl:description "A description of the services available via the end-points, including their operations, parameters etc."@en;
      shacl:name "endpoint description"@en;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path dcat:endpointDescription
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#DataService.publisher";
      shacl:class foaf:Agent;
      shacl:description "An entity (organisation) responsible for making the Data Service available."@en;
      shacl:name "publisher"@en;
      shacl:maxCount 1;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path dc:publisher
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#DataService.documentation";
      shacl:class foaf:Document;
      shacl:description "A page or document about this Data Service"@en;
      shacl:name "documentation"@en;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path foaf:page
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#DataService.description";
      shacl:description "A free-text account of the Data Service."@en;
      shacl:name "description"@en;
      shacl:nodeKind shacl:Literal;
      dash:editor dash:TextFieldEditor;
      dash:viewer dash:LiteralViewer;
      shacl:path dc:description
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#DataService.format";
      shacl:class dc:MediaTypeOrExtent;
      shacl:description "The structure that can be returned by querying the endpointURL."@en;
      shacl:name "format"@en;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path dc:format
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#DataService.contactpoint";
      shacl:class vcard:Kind;
      shacl:description "Contact information that can be used for sending comments about the Data Service."@en;
      shacl:name "contact point"@en;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path dcat:contactPoint
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#DataService.theme";
      # shacl:class skos:Concept;
      shacl:description "A category of the Data Service."@en;
      shacl:name "theme"@en;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path dcat:theme
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#DataService.licence";
      shacl:class dc:LicenseDocument;
      shacl:description "A licence under which the Data service is made available."@en;
      shacl:name "licence"@en;
      shacl:maxCount 1;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path dc:license
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#DataService.title";
      shacl:description "A name given to the Data Service."@en;
      shacl:name "title"@en;
      shacl:minCount 1;
      shacl:nodeKind shacl:Literal;
      dash:editor dash:TextFieldEditor;
      dash:viewer dash:LiteralViewer;
      shacl:path dc:title
    ];
  shacl:targetClass dcat:DataService .


',
        ARRAY ['http://www.w3.org/ns/dcat#Resource', 'http://www.w3.org/ns/dcat#DataService'],
        'INTERNAL',
        NULL,
        NULL,
        'LATEST',
        FALSE,
        FALSE,
        NULL,
        NULL,
        NOW(),
        NOW());
INSERT INTO metadata_schema_extension (uuid, metadata_schema_version_id, extended_metadata_schema_id, order_priority) VALUES ('2704c026-ac0c-4d9b-89a5-5453c52fea24', '45070030-30c1-4a56-a0a3-4ac273949496', 'ab3ce955-c4c5-4bbe-b295-501116d4301e', 0);
-- <<< End of: dataservice.sql


-- >>> File: dataset.sql
-- Dataset
INSERT INTO metadata_schema (uuid, created_at, updated_at)
VALUES ('4ecfe85e-d30a-4bcf-b125-1c6fee52683b', NOW(), NOW());
INSERT INTO metadata_schema_version (uuid, metadata_schema_id, previous_version_id, version, name, description,
                                     definition, target_classes, type, origin, imported_from, state, published,
                                     abstract, suggested_resource_name, suggested_url_prefix, created_at, updated_at)
VALUES ('5f10b562-441e-4057-bc2e-ec1cc299ae46',
        '4ecfe85e-d30a-4bcf-b125-1c6fee52683b',
        NULL,
        '1.0.0',
        'Dataset',
        '',
        '@prefix : <http://fairdatapoint.org/> .
@prefix dc: <http://purl.org/dc/terms/> .
@prefix dcat: <http://www.w3.org/ns/dcat#> .
@prefix foaf: <http://xmlns.com/foaf/0.1/> .
@prefix prov: <http://www.w3.org/ns/prov#> .
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix shacl: <http://www.w3.org/ns/shacl#> .
@prefix skos: <http://www.w3.org/2004/02/skos/core#> .
@prefix vcard: <http://www.w3.org/2006/vcard/ns#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .
@prefix dash:     <http://datashapes.org/dash#> .
@prefix healthdcatap: <http://healthdataportal.eu/ns/health#> .
@prefix csvw: <http://www.w3.org/ns/csvw#> .

:DatasetShape a shacl:NodeShape;
  shacl:closed false;
  shacl:property [
      shacl:group :DatasetOptionalSection;
  shacl:order 1;
  rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Dataset.geographicalcoverage";
      shacl:class dc:Location;
      shacl:description "A geographic region that is covered by the Dataset."@en;
      shacl:name "geographical coverage"@en;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path dc:spatial
    ], [
      shacl:group :DatasetOptionalSection;
  shacl:order 1;
  rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Dataset.otheridentifier";
      # shacl:class <http://www.w3.org/ns/adms#Identifier>;
      shacl:description "A secondary identifier of the Dataset"@en;
      shacl:name "other identifier"@en;
      shacl:node :IdentifierShape;
      dash:editor dash:BlankNodeEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path <http://www.w3.org/ns/adms#identifier>
    ], [
      shacl:group :DatasetOptionalSection;
  shacl:order 1;
  rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Dataset.frequency";
      shacl:class dc:Frequency;
      shacl:description "The frequency at which the Dataset is updated."@en;
      shacl:maxCount 1;
      shacl:name "frequency"@en;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path dc:accrualPeriodicity
    ], [
      shacl:group :DatasetOptionalSection;
  shacl:order 1;
  rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Dataset.conformsto";
      shacl:class dc:Standard;
      shacl:description "An implementing rule or other specification."@en;
      shacl:name "conforms to"@en;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      shacl:path dc:conformsTo
    ], [
      shacl:group :DatasetMandatorySection;
  shacl:order 1;
  rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Dataset.applicablelegislation";
      shacl:class <http://data.europa.eu/eli/ontology#LegalResource>;
      shacl:description "The legislation that mandates the creation or management of the Dataset."@en;
      shacl:name "applicable legislation"@en;
      shacl:minCount 1;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path <http://data.europa.eu/r5r/applicableLegislation>
    ], [
      shacl:group :DatasetOptionalSection;
  shacl:order 1;
  rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Dataset.relatedresource";
      shacl:description "A related resource."@en;
      shacl:name "related resource"@en;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path dc:relation
    ], [
      shacl:group :DatasetMandatorySection;
  shacl:order 1;
  rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Dataset.accessrights";
      shacl:class dc:RightsStatement;
      shacl:description "Information that indicates whether the Dataset is publicly accessible, has access restrictions or is not public."@en;
      shacl:name "access rights"@en;
      shacl:minCount 1;
      shacl:maxCount 1;
      shacl:in (
        <http://publications.europa.eu/resource/authority/access-right/PUBLIC>
        <http://publications.europa.eu/resource/authority/access-right/NON_PUBLIC>
        <http://publications.europa.eu/resource/authority/access-right/RESTRICTED>
      );
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:EnumSelectEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path dc:accessRights
    ], [
      shacl:group :DatasetOptionalSection;
  shacl:order 1;
  rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Dataset.temporalresolution";
      shacl:datatype xsd:duration;
      shacl:description "The minimum time period resolvable in the dataset."@en;
      shacl:name "temporal resolution"@en;
      shacl:maxCount 1;
      dash:editor dash:LiteralEditor ;
      dash:viewer dash:LiteralViewer ;
      shacl:path dcat:temporalResolution
    ], [
      shacl:group :DatasetOptionalSection;
  shacl:order 1;
  rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Dataset.version";
      shacl:description "The version indicator (name or identifier) of a resource."@en;
      shacl:name "version"@en;
      shacl:maxCount 1;
      shacl:nodeKind shacl:Literal;
      dash:editor dash:TextFieldEditor;
      dash:viewer dash:LiteralViewer;
      shacl:path dcat:version
    ], [
      shacl:group :DatasetOptionalSection;
  shacl:order 1;
  rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Dataset.wasgeneratedby";
      shacl:class prov:Activity;
      shacl:description "An activity that generated, or provides the business context for, the creation of the dataset."@en;
      shacl:name "was generated by"@en;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path prov:wasGeneratedBy
    ], [
      shacl:group :DatasetOptionalSection;
  shacl:order 1;
  rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Dataset.language";
      shacl:class dc:LinguisticSystem;
      shacl:description "A language of the Dataset."@en;
      shacl:name "language"@en;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path dc:language
    ], [
      shacl:group :DatasetOptionalSection;
  shacl:order 1;
  rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Dataset.source";
      # shacl:class dcat:Dataset;
      shacl:description "A related Dataset from which the described Dataset is derived."@en;
      shacl:name "source"@en;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path dc:source
    ], [
      shacl:group :DatasetOptionalSection;
  shacl:order 1;
  rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Dataset.landingpage";
      shacl:class foaf:Document;
      shacl:description "A web page that provides access to the Dataset, its Distributions and/or additional information."@en;
      shacl:name "landing page"@en;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path dcat:landingPage
    ], [
      shacl:group :DatasetMandatorySection;
  shacl:order 1;
  rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Dataset.type";
      shacl:description "A type of the Dataset."@en;
      shacl:name "type"@en;
      shacl:minCount 1;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path dc:type
    ], [
      shacl:group :DatasetOptionalSection;
  shacl:order 1;
  rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Dataset.isreferencedby";
      shacl:description "A related resource, such as a publication, that references, cites, or otherwise points to the dataset."@en;
      shacl:name "is referenced by"@en;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path dc:isReferencedBy
    ], [
      shacl:group :DatasetOptionalSection;
  shacl:order 1;
  rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Dataset.qualifiedrelation";
      shacl:class dcat:Relationship;
      shacl:description "A description of a relationship with another resource."@en;
      shacl:name "qualified relation"@en;
      shacl:node :RelationshipShape;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path dcat:qualifiedRelation
    ], [
      shacl:group :DatasetOptionalSection;
  shacl:order 1;
  rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Dataset.spatialresolution";
      shacl:datatype xsd:decimal;
      shacl:description "The minimum spatial separation resolvable in a dataset, measured in meters."@en;
      shacl:name "spatial resolution"@en;
      shacl:nodeKind shacl:Literal;
      dash:editor dash:LiteralEditor;
      dash:viewer dash:LiteralViewer;
      shacl:path dcat:spatialResolutionInMeters
    ], [
      shacl:group :DatasetOptionalSection;
  shacl:order 1;
  rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Dataset.hasversion";
      # shacl:class dcat:Dataset;
      shacl:description "A related Dataset that is a version, edition, or adaptation of the described Dataset."@en;
      shacl:name "has version"@en;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path dcat:hasVersion
    ], [
      shacl:group :DatasetOptionalSection;
  shacl:order 1;
  rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Dataset.releasedate";
      shacl:maxCount 1;
      shacl:description "The date of formal issuance (e.g., publication) of the Dataset."@en;
      shacl:name "release date"@en;
      shacl:nodeKind shacl:Literal;
      dash:editor dash:DateTimePickerEditor;
      dash:viewer dash:LiteralViewer;
      shacl:path dc:issued
    ], [
      shacl:group :DatasetMandatorySection;
  shacl:order 1;
  rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Dataset.keyword";
      shacl:description "A keyword or tag describing the Dataset."@en;
      shacl:name "keyword"@en;
      shacl:minCount 1;
      shacl:nodeKind shacl:Literal;
      dash:editor dash:TextFieldEditor;
      dash:viewer dash:LiteralViewer;
      shacl:path dcat:keyword
    ], [
      shacl:group :DatasetMandatorySection;
  shacl:order 1;
  rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Dataset.provenance";
      shacl:description "A statement about the lineage of a Dataset."@en;
      shacl:name "provenance"@en;
      shacl:minCount 1;
      shacl:nodeKind shacl:Literal;
      dash:editor dash:TextFieldEditor;
      dash:viewer dash:LiteralViewer;
      shacl:path dc:provenance
    ], [
      shacl:group :DatasetOptionalSection;
  shacl:order 1;
  rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Dataset.inseries";
      # shacl:class dcat:DatasetSeries;
      shacl:description "A dataset series of which the dataset is part."@en;
      shacl:name "in series"@en;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path dcat:inSeries
    ], [
      shacl:group :DatasetOptionalSection;
  shacl:order 1;
  rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Dataset.publisher";
      # shacl:class foaf:Agent;
      shacl:description "An entity (organisation) responsible for making the Dataset available."@en;
      shacl:name "publisher"@en;
      shacl:maxCount 1;
      shacl:node :PublisherShape;
      dash:editor dash:BlankNodeEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path dc:publisher
    ], [
      shacl:group :DatasetOptionalSection;
  shacl:order 1;
  rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Dataset.documentation";
      shacl:class foaf:Document;
      shacl:description "A page or document about this Dataset."@en;
      shacl:name "documentation"@en;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path foaf:page
    ], [
      shacl:group :DatasetOptionalSection;
  shacl:order 1;
  rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Dataset.modificationdate";
      shacl:description "The most recent date on which the Dataset was changed or modified."@en;
      shacl:name "modification date"@en;
      shacl:maxCount 1;
      shacl:nodeKind shacl:Literal;
      dash:editor dash:DateTimePickerEditor;
      dash:viewer dash:LiteralViewer;
      shacl:path dc:modified
    ], [
      shacl:group :DatasetMandatorySection;
  shacl:order 1;
  rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Dataset.description";
      shacl:description "A free-text account of the Dataset."@en;
      shacl:name "description"@en;
      shacl:minCount 1;
      shacl:nodeKind shacl:Literal;
      dash:editor dash:TextFieldEditor;
      dash:viewer dash:LiteralViewer;
      shacl:path dc:description
    ], [
      shacl:group :DatasetMandatorySection;
  shacl:order 1;
  rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Dataset.contactpoint";
      shacl:class vcard:Kind;
      shacl:description "Contact information that can be used for sending comments about the Dataset."@en;
      shacl:name "contact point"@en;
      shacl:minCount 1;
      shacl:node :ContactPointShape;
      dash:editor dash:BlankNodeEditor ;
      dash:viewer dash:DetailsViewer ;
      shacl:path dcat:contactPoint
    ], [
      shacl:group :DatasetOptionalSection;
  shacl:order 1;
  rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Dataset.creator";
      shacl:class foaf:Agent;
      shacl:description "An entity responsible for producing the dataset."@en;
      shacl:name "creator"@en;
      shacl:node :AgentShape;
      dash:editor dash:BlankNodeEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path dc:creator
    ], [
      shacl:group :DatasetOptionalSection;
  shacl:order 1;
  rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Dataset.temporalcoverage";
      shacl:class dc:PeriodOfTime;
      shacl:description "A temporal period that the Dataset covers."@en;
      shacl:name "temporal coverage"@en;
      shacl:node :PeriodOfTimeShape;
      dash:editor dash:BlankNodeEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path dc:temporal
    ], [
      shacl:group :DatasetOptionalSection;
  shacl:order 1;
  rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Dataset.qualifiedattribution";
      shacl:class prov:Attribution;
      shacl:description "An Agent having some form of responsibility for the resource."@en;
      shacl:name "qualified attribution"@en;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path prov:qualifiedAttribution
    ], [
      shacl:group :DatasetMandatorySection;
  shacl:order 1;
  rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Dataset.theme";
      # shacl:class skos:Concept;
      shacl:description "A category of the Dataset."@en;
      shacl:name "theme"@en;
      shacl:minCount 1;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path dcat:theme
    ], [
      shacl:group :DatasetMandatorySection;
  shacl:order 1;
  rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Dataset.identifier";
      shacl:description "The main identifier for the Dataset, e.g. the URI or other unique identifier in the context of the Catalogue."@en;
      shacl:name "identifier"@en;
      shacl:minCount 1;
      shacl:datatype xsd:anyURI;
      shacl:nodeKind shacl:Literal;
      dash:editor dash:LiteralEditor;
      dash:viewer dash:LiteralViewer;
      shacl:path dc:identifier
    ], [
      shacl:group :DatasetOptionalSection;
  shacl:order 1;
  rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Dataset.versionnotes";
      shacl:description "A description of the differences between this version and a previous version of the Dataset."@en;
      shacl:name "version notes"@en;
      shacl:nodeKind shacl:Literal;
      dash:editor dash:TextFieldEditor;
      dash:viewer dash:LiteralViewer;
      shacl:path <http://www.w3.org/ns/adms#versionNotes>
    ], [
      shacl:group :DatasetMandatorySection;
  shacl:order 1;
  rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Dataset.title";
      shacl:description "A name given to the Dataset."@en;
      shacl:name "title"@en;
      shacl:minCount 1;
      shacl:nodeKind shacl:Literal;
      dash:editor dash:TextFieldEditor;
      dash:viewer dash:LiteralViewer;
      shacl:path dc:title
    ], [
      shacl:group :DatasetMandatorySection;
  shacl:order 1;
      shacl:description "Health Data Access Body supporting access to data in the Member State."@en;
      shacl:name "health data access body"@en;
      shacl:minCount 1;
      shacl:maxCount 1;
      shacl:node :HDABShape;
      dash:editor dash:BlankNodeEditor;
      dash:viewer dash:DetailsViewer;
      shacl:path healthdcatap:hdab
    ], [
      # shacl:class skos:Concept;
      shacl:group :DatasetMandatorySection;
  shacl:order 1;
      shacl:description "The health category to which this dataset belongs."@en;
      shacl:name "health category"@en;
      shacl:minCount 1;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:URIEditor;
      dash:viewer dash:LabelViewer;
      shacl:path healthdcatap:healthCategory
    ], [
      # shacl:class skos:Concept;
      shacl:group :DatasetOptionalSection;
  shacl:order 1;
      shacl:description "A category of the Dataset or tag describing the Dataset."@en;
      shacl:name "health theme"@en;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:URIEditor;
      dash:viewer dash:LabelViewer;
      shacl:path healthdcatap:healthTheme
    ], [
      shacl:group :DatasetMandatorySection;
  shacl:order 1;
  rdfs:seeAlso "https://healthdataeu.pages.code.europa.eu/healthdcat-ap/releases/release-7/";
      shacl:datatype xsd:boolean;
      shacl:description "Indicates whether the Dataset contains structured data for which a machine-readable description of the data variables can be provided."@en;
      shacl:name "structured data"@en;
      shacl:minCount 1;
      shacl:maxCount 1;
      shacl:nodeKind shacl:Literal;
      dash:editor dash:BooleanSelectEditor;
      dash:viewer dash:LiteralViewer;
      shacl:path healthdcatap:hasStructuredData
    ], [
      # shacl:class csvw:TableGroup;
      shacl:group :DatasetMandatorySection;
  shacl:order 1;
  rdfs:seeAlso "https://healthdataeu.pages.code.europa.eu/healthdcat-ap/releases/release-7/";
      shacl:description "Links the Dataset to a CSVW TableGroup describing its variables. Becomes mandatory when structured data is true."@en;
      shacl:name "variables"@en;
      shacl:nodeKind shacl:IRI;
      dash:editor dash:URIEditor;
      dash:viewer dash:LabelViewer;
      shacl:path healthdcatap:hasVariables
    ];
  shacl:targetClass dcat:Dataset .

:DatasetMandatorySection
  rdfs:label "Mandatory" ;
  rdfs:comment "Contains the essential dataset metadata required for identification and minimal compliance with DCAT-AP and HealthDCAT-AP." ;
  shacl:order 1 .

:DatasetOptionalSection
  rdfs:label "Optional" ;
  rdfs:comment "" ;
  shacl:order 2 .

',
        ARRAY ['http://www.w3.org/ns/dcat#Resource', 'http://www.w3.org/ns/dcat#Dataset'],
        'INTERNAL',
        NULL,
        NULL,
        'LATEST',
        FALSE,
        FALSE,
        NULL,
        NULL,
        NOW(),
        NOW());
INSERT INTO metadata_schema_extension (uuid, metadata_schema_version_id, extended_metadata_schema_id, order_priority) VALUES ('7f27f311-135b-4d3d-a4d7-cbf191100ab8', '5f10b562-441e-4057-bc2e-ec1cc299ae46', 'ab3ce955-c4c5-4bbe-b295-501116d4301e', 0);
-- <<< End of: dataset.sql


-- >>> File: datasetseries.sql
-- DatasetSeries
INSERT INTO metadata_schema (uuid, created_at, updated_at)
VALUES ('dc183ac6-8256-4254-bfc6-cf25100d66c6', NOW(), NOW());
INSERT INTO metadata_schema_version (uuid, metadata_schema_id, previous_version_id, version, name, description,
                                     definition, target_classes, type, origin, imported_from, state, published,
                                     abstract, suggested_resource_name, suggested_url_prefix, created_at, updated_at)
VALUES ('6894a38e-6463-4954-81cf-de451ec3fe2f',
        'dc183ac6-8256-4254-bfc6-cf25100d66c6',
        NULL,
        '1.0.0',
        'DatasetSeries',
        '',
        '@prefix : <http://fairdatapoint.org/> .
@prefix dc: <http://purl.org/dc/terms/> .
@prefix dcat: <http://www.w3.org/ns/dcat#> .
@prefix foaf: <http://xmlns.com/foaf/0.1/> .
@prefix prov: <http://www.w3.org/ns/prov#> .
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix shacl: <http://www.w3.org/ns/shacl#> .
@prefix skos: <http://www.w3.org/2004/02/skos/core#> .
@prefix vcard: <http://www.w3.org/2006/vcard/ns#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .
@prefix dash:     <http://datashapes.org/dash#> .

:DatasetSeriesShape a shacl:NodeShape;
  shacl:closed false;
  shacl:property [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#DatasetSeries.geographicalcoverage";
      shacl:group :DSOptional;
      shacl:class dc:Location;
      shacl:description "A geographic region that is covered by the Dataset Series."@en;
      shacl:name "geographical coverage"@en;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path dc:spatial
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#DatasetSeries.frequency";
      shacl:group :DSOptional;
      shacl:class dc:Frequency;
      shacl:description "The frequency at which the Dataset Series is updated."@en;
      shacl:name "frequency"@en;
      shacl:maxCount 1;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path dc:accrualPeriodicity
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#DatasetSeries.applicablelegislation";
      shacl:group :DSMandatory;
      shacl:class <http://data.europa.eu/eli/ontology#LegalResource>;
      shacl:description "The legislation that mandates the creation or management of the Dataset Series."@en;
      shacl:name "applicable legislation"@en;
      shacl:minCount 1;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path <http://data.europa.eu/r5r/applicableLegislation>
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#DatasetSeries.releasedate";
      shacl:group :DSOptional;
      shacl:description "The date of formal issuance (e.g., publication) of the Dataset Series."@en;
      shacl:name "release date"@en;
      shacl:maxCount 1;
      shacl:nodeKind shacl:Literal;
      dash:editor dash:DateTimePickerEditor;
      dash:viewer dash:LiteralViewer;
      shacl:path dc:issued
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#DatasetSeries.publisher";
      shacl:group :DSOptional;
      # shacl:class foaf:Agent;
      shacl:description "An entity (organisation) responsible for ensuring the coherency of the Dataset Series "@en;
      shacl:name "publisher"@en;
      shacl:maxCount 1;
      shacl:node :PublisherShape;
      dash:editor dash:BlankNodeEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path dc:publisher
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#DatasetSeries.modificationdate";
      shacl:group :DSOptional;
      shacl:description "The most recent date on which the Dataset Series was changed or modified."@en;
      shacl:name "modification date"@en;
      shacl:maxCount 1;
      shacl:nodeKind shacl:Literal;
      dash:editor dash:DateTimePickerEditor;
      dash:viewer dash:LiteralViewer;
      shacl:path dc:modified
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#DatasetSeries.description";
      shacl:group :DSMandatory;
      shacl:description "A free-text account of the Dataset Series."@en;
      shacl:name "description"@en;
      shacl:minCount 1;
      shacl:nodeKind shacl:Literal;
      dash:editor dash:TextFieldEditor;
      dash:viewer dash:LiteralViewer;
      shacl:path dc:description
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#DatasetSeries.contactpoint";
      shacl:group :DSOptional;
      shacl:class vcard:Kind;
      shacl:description "Contact information that can be used for sending comments about the Dataset Series."@en;
      shacl:name "contact point"@en;
      shacl:node :ContactPointShape;
      dash:editor dash:BlankNodeEditor ;
      dash:viewer dash:DetailsViewer ;
      shacl:path dcat:contactPoint
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#DatasetSeries.temporalcoverage";
      shacl:group :DSOptional;
      shacl:class dc:PeriodOfTime;
      shacl:description "A temporal period that the Dataset Series covers."@en;
      shacl:name "temporal coverage"@en;
      shacl:node :PeriodOfTimeShape;
      dash:editor dash:BlankNodeEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:path dc:temporal
    ], [
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#DatasetSeries.title";
      shacl:group :DSMandatory;
      shacl:description "A name given to the Dataset Series."@en;
      shacl:name "title"@en;
      shacl:minCount 1;
      shacl:nodeKind shacl:Literal;
      dash:editor dash:TextFieldEditor;
      dash:viewer dash:LiteralViewer;
      shacl:path dc:title
    ];
  shacl:targetClass dcat:DatasetSeries .

:DSMandatory
  rdfs:label "Mandatory" ;
  rdfs:comment "Contains the essential Dataset Service metadata required for identification and minimal compliance with DCAT-AP and HealthDCAT-AP." ;
  shacl:order 1 .

:DSOptional
  rdfs:label "Optional" ;
  rdfs:comment "" ;
  shacl:order 2 .

',
        ARRAY ['http://www.w3.org/ns/dcat#Resource', 'http://www.w3.org/ns/dcat#DatasetSeries'],
        'INTERNAL',
        NULL,
        NULL,
        'LATEST',
        FALSE,
        FALSE,
        NULL,
        NULL,
        NOW(),
        NOW());
INSERT INTO metadata_schema_extension (uuid, metadata_schema_version_id, extended_metadata_schema_id, order_priority) VALUES ('70ca8598-427a-4a3b-95df-be4f06aac03f', '6894a38e-6463-4954-81cf-de451ec3fe2f', 'ab3ce955-c4c5-4bbe-b295-501116d4301e', 0);
-- <<< End of: datasetseries.sql


-- >>> File: distribution.sql
-- Distribution
INSERT INTO metadata_schema (uuid, created_at, updated_at)
VALUES ('58086042-16be-4e9a-93a4-4230f7b70d12', NOW(), NOW());
INSERT INTO metadata_schema_version (uuid, metadata_schema_id, previous_version_id, version, name, description,
                                     definition, target_classes, type, origin, imported_from, state, published,
                                     abstract, suggested_resource_name, suggested_url_prefix, created_at, updated_at)
VALUES ('307c8fd0-c5a9-41ea-a6e9-17a4c397939d',
        '58086042-16be-4e9a-93a4-4230f7b70d12',
        NULL,
        '1.0.0',
        'Distribution',
        '',
        '@prefix : <http://fairdatapoint.org/> .
@prefix dc: <http://purl.org/dc/terms/> .
@prefix dcat: <http://www.w3.org/ns/dcat#> .
@prefix foaf: <http://xmlns.com/foaf/0.1/> .
@prefix prov: <http://www.w3.org/ns/prov#> .
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix shacl: <http://www.w3.org/ns/shacl#> .
@prefix skos: <http://www.w3.org/2004/02/skos/core#> .
@prefix vcard: <http://www.w3.org/2006/vcard/ns#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .
@prefix dash:     <http://datashapes.org/dash#> .



:DistributionShape a shacl:NodeShape;
  shacl:closed false;
  shacl:property [
    rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Distribution.mediatype" ;
    shacl:group :DistOptional ;
    shacl:class dc:MediaType ;
    shacl:description "The media type of the Distribution as defined in the official register of media types managed by IANA."@en ;
    shacl:name "media type"@en ;
    shacl:nodeKind shacl:BlankNodeOrIRI ;
    dash:editor dash:URIEditor ;
    dash:viewer dash:LabelViewer ;
    shacl:maxCount 1 ;
    shacl:path dcat:mediaType
  ] ,
  [
    rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Distribution.availability" ;
    shacl:group :DistOptional ;
    # shacl:class skos:Concept ;
    shacl:description "An indication how long it is planned to keep the Distribution of the Dataset available."@en ;
    shacl:name "availability"@en ;
    shacl:nodeKind shacl:BlankNodeOrIRI ;
    dash:editor dash:URIEditor ;
    dash:viewer dash:LabelViewer ;
    shacl:maxCount 1 ;
    shacl:path <http://data.europa.eu/r5r/availability>
  ] ,
  [
    rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Distribution.applicablelegislation" ;
    shacl:group :DistMandatory ;
    shacl:class <http://data.europa.eu/eli/ontology#LegalResource> ;
    shacl:description "The legislation that mandates the creation or management of the Distribution."@en ;
    shacl:name "applicable legislation"@en ;
    shacl:nodeKind shacl:BlankNodeOrIRI ;
    dash:editor dash:URIEditor ;
    dash:viewer dash:LabelViewer ;
    shacl:minCount 1 ;
    shacl:path <http://data.europa.eu/r5r/applicableLegislation>
  ] ,
  [
    rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Distribution.status" ;
    shacl:group :DistOptional ;
    # shacl:class skos:Concept ;
    shacl:description "The status of the distribution in the context of maturity lifecycle."@en ;
    shacl:name "status"@en ;
    shacl:nodeKind shacl:BlankNodeOrIRI ;
    dash:editor dash:URIEditor ;
    dash:viewer dash:LabelViewer ;
    shacl:maxCount 1 ;
    shacl:path <http://www.w3.org/ns/adms#status>
  ] ,
  [
    rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Distribution.temporalresolution" ;
    shacl:group :DistOptional ;
    shacl:datatype xsd:duration ;
    shacl:description "The minimum time period resolvable in the dataset distribution."@en ;
    shacl:name "temporal resolution"@en ;
    shacl:nodeKind shacl:Literal ;
    dash:editor dash:LiteralEditor ;
    dash:viewer dash:LiteralViewer ;
    shacl:maxCount 1 ;
    shacl:path dcat:temporalResolution
  ] ,
  [
    rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Distribution.compressionformat" ;
    shacl:group :DistOptional ;
    shacl:class dc:MediaType ;
    shacl:description "The format of the file in which the data is contained in a compressed form, e.g. to reduce the size of the downloadable file."@en ;
    shacl:name "compression format"@en ;
    shacl:nodeKind shacl:BlankNodeOrIRI ;
    dash:editor dash:URIEditor ;
    dash:viewer dash:LabelViewer ;
    shacl:maxCount 1 ;
    shacl:path dcat:compressFormat
  ] ,
  [
    rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Distribution.linkedschemas" ;
    shacl:group :DistOptional ;
    shacl:class dc:Standard ;
    shacl:description "An established schema to which the described Distribution conforms."@en ;
    shacl:name "linked schemas"@en ;
    shacl:nodeKind shacl:BlankNodeOrIRI ;
    shacl:path dc:conformsTo
  ] ,
  [
    rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Distribution.accessservice" ;
    shacl:group :DistOptional ;
    # shacl:class dcat:DataService ;
    shacl:description "A data service that gives access to the distribution of the dataset."@en ;
    shacl:name "access service"@en ;
    shacl:nodeKind shacl:BlankNodeOrIRI ;
    dash:editor dash:URIEditor ;
    dash:viewer dash:LabelViewer ;
    shacl:path dcat:accessService
  ] ,
  [
    rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Distribution.downloadURL" ;
    shacl:group :DistOptional ;
    shacl:description "A URL that is a direct link to a downloadable file in a given format."@en ;
    shacl:name "download URL"@en ;
    shacl:nodeKind shacl:BlankNodeOrIRI ;
    dash:editor dash:URIEditor ;
    dash:viewer dash:LabelViewer ;
    shacl:path dcat:downloadURL
  ] ,
  [
    rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Distribution.language" ;
    shacl:group :DistOptional ;
    shacl:class dc:LinguisticSystem ;
    shacl:description "A language used in the Distribution."@en ;
    shacl:name "language"@en ;
    shacl:nodeKind shacl:BlankNodeOrIRI ;
    dash:editor dash:URIEditor ;
    dash:viewer dash:LabelViewer ;
    shacl:path dc:language
  ] ,
  [
    rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Distribution.haspolicy" ;
    shacl:group :DistOptional ;
    shacl:class <http://www.w3.org/ns/odrl/2/Policy> ;
    shacl:description "The policy expressing the rights associated with the distribution if using the ODRL vocabulary."@en ;
    shacl:name "has policy"@en ;
    shacl:nodeKind shacl:BlankNodeOrIRI ;
    dash:editor dash:URIEditor ;
    dash:viewer dash:LabelViewer ;
    shacl:maxCount 1 ;
    shacl:path <http://www.w3.org/ns/odrl/2/hasPolicy>
  ] ,
  [
    rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Distribution.packagingformat" ;
    shacl:group :DistOptional ;
    shacl:class dc:MediaType ;
    shacl:description "The format of the file in which one or more data files are grouped together, e.g. to enable a set of related files to be downloaded together."@en ;
    shacl:name "packaging format"@en ;
    shacl:nodeKind shacl:BlankNodeOrIRI ;
    dash:editor dash:URIEditor ;
    dash:viewer dash:LabelViewer ;
    shacl:maxCount 1 ;
    shacl:path dcat:packageFormat
  ] ,
  [
    rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Distribution.spatialresolution" ;
    shacl:group :DistOptional ;
    shacl:datatype xsd:decimal ;
    shacl:description "The minimum spatial separation resolvable in a dataset distribution, measured in meters."@en ;
    shacl:name "spatial resolution"@en ;
    shacl:nodeKind shacl:Literal ;
    dash:editor dash:LiteralEditor ;
    dash:viewer dash:LiteralViewer ;
    shacl:maxCount 1 ;
    shacl:path dcat:spatialResolutionInMeters
  ] ,
  [
    rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Distribution.releasedate" ;
    shacl:group :DistOptional ;
    shacl:description "The date of formal issuance (e.g., publication) of the Distribution."@en ;
    shacl:name "release date"@en ;
    shacl:nodeKind shacl:Literal ;
    dash:editor dash:DateTimePickerEditor;
    dash:viewer dash:LiteralViewer;
    shacl:maxCount 1 ;
    shacl:path dc:issued
  ] ,
  [
    rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Distribution.bytesize" ;
    shacl:group :DistOptional ;
    shacl:datatype xsd:nonNegativeInteger ;
    shacl:description "The size of a Distribution in bytes."@en ;
    shacl:name "byte size"@en ;
    shacl:nodeKind shacl:Literal ;
    dash:editor dash:LiteralEditor ;
    dash:viewer dash:LiteralViewer ;
    shacl:maxCount 1 ;
    shacl:path dcat:byteSize
  ] ,
  [
    rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Distribution.checksum" ;
    shacl:group :DistOptional ;
    shacl:class <http://spdx.org/rdf/terms#Checksum> ;
    shacl:description "A mechanism that can be used to verify that the contents of a distribution have not changed."@en ;
    shacl:name "checksum"@en ;
    shacl:node :ChecksumShape ;
    dash:editor dash:BlankNodeEditor ;
    dash:viewer dash:LabelViewer ;
    shacl:maxCount 1 ;
    shacl:path <http://spdx.org/rdf/terms#checksum>
  ] ,
  [
    rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Distribution.documentation" ;
    shacl:group :DistOptional ;
    shacl:class foaf:Document ;
    shacl:description "A page or document about this Distribution."@en ;
    shacl:name "documentation"@en ;
    shacl:nodeKind shacl:BlankNodeOrIRI ;
    dash:editor dash:URIEditor ;
    dash:viewer dash:LabelViewer ;
    shacl:path foaf:page
  ] ,
  [
    rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Distribution.modificationdate" ;
    shacl:group :DistOptional ;
    shacl:datatype xsd:date ;
    shacl:description "The most recent date on which the Distribution was changed or modified."@en ;
    shacl:name "modification date"@en ;
    shacl:nodeKind shacl:Literal ;
    dash:editor dash:DatePickerEditor ;
    dash:viewer dash:LiteralViewer ;
    shacl:maxCount 1 ;
    shacl:path dc:modified
  ] ,
  [
    rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Distribution.description" ;
    shacl:group :DistOptional ;
    shacl:description "A free-text account of the Distribution."@en ;
    shacl:name "description"@en ;
    shacl:nodeKind shacl:Literal ;
    dash:editor dash:TextFieldEditor ;
    dash:viewer dash:LiteralViewer ;
    shacl:path dc:description
  ] ,
  [
    rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Distribution.format" ;
    shacl:group :DistOptional ;
    shacl:class dc:MediaTypeOrExtent ;
    shacl:description "The file format of the Distribution."@en ;
    shacl:name "format"@en ;
    shacl:nodeKind shacl:BlankNodeOrIRI ;
    dash:editor dash:URIEditor ;
    dash:viewer dash:LabelViewer ;
    shacl:maxCount 1 ;
    shacl:path dc:format
  ] ,
  [
    rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Distribution.rights" ;
    shacl:group :DistOptional ;
    shacl:class dc:RightsStatement ;
    shacl:description "A statement that specifies rights associated with the Distribution."@en ;
    shacl:name "rights"@en ;
    shacl:nodeKind shacl:BlankNodeOrIRI ;
    dash:editor dash:URIEditor ;
    dash:viewer dash:LabelViewer ;
    shacl:path dc:rights
  ] ,
  [
    rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Distribution.licence" ;
    shacl:group :DistOptional ;
    shacl:class dc:LicenseDocument ;
    shacl:description "A licence under which the Distribution is made available."@en ;
    shacl:name "licence"@en ;
    shacl:nodeKind shacl:BlankNodeOrIRI ;
    dash:editor dash:URIEditor ;
    dash:viewer dash:LabelViewer ;
    shacl:maxCount 1 ;
    shacl:path dc:license
  ] ,
  [
    rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Distribution.accessURL" ;
    shacl:group :DistMandatory ;
    shacl:description "A URL that gives access to a Distribution of the Dataset."@en ;
    shacl:name "access URL"@en ;
    shacl:nodeKind shacl:BlankNodeOrIRI ;
    dash:editor dash:URIEditor ;
    dash:viewer dash:LabelViewer ;
    shacl:minCount 1 ;
    shacl:path dcat:accessURL
  ] ,
  [
    rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Distribution.title" ;
    shacl:group :DistOptional ;
    shacl:description "A name given to the Distribution."@en ;
    shacl:name "title"@en ;
    shacl:nodeKind shacl:Literal ;
    dash:editor dash:TextFieldEditor ;
    dash:viewer dash:LiteralViewer ;
    shacl:path dc:title
  ];
  shacl:targetClass dcat:Distribution .

:DistMandatory
  rdfs:label "Mandatory" ;
  rdfs:comment "Contains the essential dataset Distribution metadata required for identification and minimal compliance with DCAT-AP and HealthDCAT-AP." ;
  shacl:order 1 .

:DistOptional
  rdfs:label "Optional" ;
  rdfs:comment "" ;
  shacl:order 2 .


',
        ARRAY ['http://www.w3.org/ns/dcat#Resource', 'http://www.w3.org/ns/dcat#Distribution'],
        'INTERNAL',
        NULL,
        NULL,
        'LATEST',
        FALSE,
        FALSE,
        NULL,
        NULL,
        NOW(),
        NOW());
INSERT INTO metadata_schema_extension (uuid, metadata_schema_version_id, extended_metadata_schema_id, order_priority) VALUES ('3fe940ce-ba07-45b9-a7e0-43cb91f60db7', '307c8fd0-c5a9-41ea-a6e9-17a4c397939d', 'ab3ce955-c4c5-4bbe-b295-501116d4301e', 0);
-- <<< End of: distribution.sql

-- >>> File: csvw.sql
-- CSVW
INSERT INTO metadata_schema (uuid, created_at, updated_at)
VALUES ('1cbed087-6b21-4cc8-9da4-4defc56d6a8a', NOW(), NOW());
INSERT INTO metadata_schema_version (uuid, metadata_schema_id, previous_version_id, version, name, description,
                                     definition, target_classes, type, origin, imported_from, state, published,
                                     abstract, suggested_resource_name, suggested_url_prefix, created_at, updated_at)
VALUES ('b6f4f592-9338-4387-a53f-9a6e3f546620',
        '1cbed087-6b21-4cc8-9da4-4defc56d6a8a',
        NULL,
        '1.0.0',
        'CSVWTableGroup',
        '',
        '@prefix : <http://fairdatapoint.org/> .
@prefix dc: <http://purl.org/dc/terms/> .
@prefix dcat: <http://www.w3.org/ns/dcat#> .
@prefix foaf: <http://xmlns.com/foaf/0.1/> .
@prefix prov: <http://www.w3.org/ns/prov#> .
@prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#> .
@prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#> .
@prefix shacl: <http://www.w3.org/ns/shacl#> .
@prefix skos: <http://www.w3.org/2004/02/skos/core#> .
@prefix vcard: <http://www.w3.org/2006/vcard/ns#> .
@prefix xsd: <http://www.w3.org/2001/XMLSchema#> .
@prefix dash: <http://datashapes.org/dash#> .
@prefix csvw: <http://www.w3.org/ns/csvw#> .

:DefaultGroup shacl:order 1 .

:CSVWTableGroupShape a shacl:NodeShape;
  rdfs:label "Data Dictionary" ;
  shacl:closed false;
  shacl:property [
    shacl:group :DefaultGroup ;
    shacl:class csvw:Table ;
    shacl:description "A table is a single CSV file within a CSVW Table Group."@en ;
    shacl:name "table"@en ;
    shacl:node :CSVWTableShape ;
    dash:editor dash:BlankNodeEditor ;
    dash:viewer dash:DetailsViewer ;
    shacl:minCount 1 ;
    shacl:path csvw:table
  ];
  shacl:targetClass csvw:TableGroup .

:CSVWTableShape a shacl:NodeShape;
  shacl:closed false;
  shacl:property [
    shacl:group :DefaultGroup ;
    shacl:class csvw:Column ;
    shacl:description "Variable (column) defines metadata about one field in the CSV file."@en ;
    shacl:name "column"@en ;
    shacl:node :CSVWColumnShape ;
    dash:editor dash:BlankNodeEditor ;
    dash:viewer dash:DetailsViewer ;
    shacl:minCount 1 ;
    shacl:path csvw:column
  ] ,
  [
    shacl:group :DefaultGroup ;
    shacl:description "The URL of the CSV file to which this table refers."@en ;
    shacl:name "url"@en ;
    shacl:nodeKind shacl:IRI ;
    dash:editor dash:URIEditor ;
    dash:viewer dash:LabelViewer ;
    shacl:maxCount 1 ;
    shacl:path csvw:url
  ] ,
  [
    shacl:group :DefaultGroup ;
    shacl:description "A keyword or tag describing the table."@en ;
    shacl:name "keyword"@en ;
    shacl:nodeKind shacl:Literal ;
    dash:editor dash:LiteralEditor ;
    dash:viewer dash:LiteralViewer ;
    shacl:path dcat:keyword
  ];
  shacl:targetClass csvw:Table .


:CSVWColumnShape a shacl:NodeShape;
  shacl:closed false;
  shacl:property [
    shacl:group :DefaultGroup ;
    shacl:description "A Technical name given to the Variable as it appears in the CSV file."@en ;
    shacl:name "name"@en ;
    shacl:nodeKind shacl:Literal ;
    dash:editor dash:LiteralEditor ;
    dash:viewer dash:LiteralViewer ;
    shacl:minCount 1 ;
    shacl:path csvw:name
  ] ,
  [
    shacl:group :DefaultGroup ;
    shacl:description "A Human-readable name given to the Variable."@en ;
    shacl:name "title"@en ;
    shacl:nodeKind shacl:Literal ;
    dash:editor dash:LiteralEditor ;
    # dash:viewer dash:LiteralViewer ;
    shacl:minCount 1 ;
    shacl:path csvw:titles
  ] ,
  [
    shacl:group :DefaultGroup ;
    shacl:description "Variable description."@en ;
    shacl:name "description"@en ;
    shacl:nodeKind shacl:Literal ;
    dash:editor dash:LiteralEditor ;
    # dash:viewer dash:LiteralViewer ;
    shacl:minCount 1 ;
    shacl:path dc:description
  ] ,
  [
    shacl:group :DefaultGroup ;
    shacl:description "Specifies the expected datatype of the values in the column."@en ;
    shacl:name "datatype"@en ;
    shacl:nodeKind shacl:Literal ;
    dash:editor dash:LiteralEditor ;
    dash:viewer dash:LiteralViewer ;
    shacl:minCount 1 ;
    shacl:maxCount 1 ;
    shacl:path csvw:datatype
  ] ,
  [
    shacl:group :DefaultGroup ;
    shacl:description "A URI template used to define the RDF predicate associated with the values in the column, relative to each row."@en ;
    shacl:name "property url"@en ;
    shacl:nodeKind shacl:IRI ;
    dash:editor dash:URIEditor ;
    dash:viewer dash:LabelViewer ;
    shacl:maxCount 1 ;
    shacl:path csvw:propertyUrl
  ];
  shacl:targetClass csvw:Column .

',
        ARRAY ['http://www.w3.org/ns/dcat#Resource', 'http://www.w3.org/ns/csvw#TableGroup'],
        'INTERNAL',
        NULL,
        NULL,
        'LATEST',
        FALSE,
        FALSE,
        NULL,
        NULL,
        NOW(),
        NOW());
INSERT INTO metadata_schema_extension (uuid, metadata_schema_version_id, extended_metadata_schema_id, order_priority) VALUES ('e322f68f-7ba1-40ba-b93e-fafd00d30046', 'b6f4f592-9338-4387-a53f-9a6e3f546620', 'ab3ce955-c4c5-4bbe-b295-501116d4301e', 0);
-- <<< End of: csvw.sql

-- Metadata Service
INSERT INTO metadata_schema (uuid, created_at, updated_at)
VALUES ('6f7a5a76-6185-4bd0-9fe9-62ecc90c9bad', NOW(), NOW());
INSERT INTO metadata_schema_version (uuid, metadata_schema_id, previous_version_id, version, name, description,
                                     definition, target_classes, type, origin, imported_from, state, published,
                                     abstract, suggested_resource_name, suggested_url_prefix, created_at, updated_at)
VALUES ('36b22b70-6203-4dd2-9fb6-b39a776bf467',
        '6f7a5a76-6185-4bd0-9fe9-62ecc90c9bad',
        NULL,
        '1.0.0',
        'Metadata Service',
        '',
        '@prefix :         <http://fairdatapoint.org/> .
@prefix dash:     <http://datashapes.org/dash#> .
@prefix dct:      <http://purl.org/dc/terms/> .
@prefix fdp:      <https://w3id.org/fdp/fdp-o#> .
@prefix sh:       <http://www.w3.org/ns/shacl#> .
@prefix xsd:      <http://www.w3.org/2001/XMLSchema#> .

:MetadataServiceShape a sh:NodeShape ;
  sh:property [
    sh:path dct:title ;
    sh:nodeKind sh:Literal ;
    sh:minCount 1 ;
    sh:maxCount  1 ;
    dash:editor dash:TextFieldEditor ;
    sh:order 1 ;
  ], [
    sh:path dct:description ;
    sh:nodeKind sh:Literal ;
    sh:maxCount 1 ;
    dash:editor dash:TextAreaEditor ;
    sh:order 2 ;
  ], [
    sh:path dct:publisher ;
    sh:node :AgentShape ;
    sh:minCount 1 ;
    sh:maxCount 1 ;
    dash:editor dash:BlankNodeEditor ;
    sh:order 3 ;
  ], [
    sh:path dcat:version ;
    sh:name "version" ;
    sh:nodeKind sh:Literal ;
    sh:minCount 1 ;
    sh:maxCount 1 ;
    dash:editor dash:TextFieldEditor ;
    dash:viewer dash:LiteralViewer ;
    sh:order 4 ;
  ], [
    sh:path dct:language ;
    sh:nodeKind sh:IRI ;
    sh:maxCount 1 ;
    dash:editor dash:URIEditor ;
    dash:viewer dash:LabelViewer ;
    sh:defaultValue <http://id.loc.gov/vocabulary/iso639-1/en> ;
    sh:order 5 ;
  ], [
    sh:path dct:license ;
    sh:nodeKind sh:IRI ;
    sh:maxCount 1 ;
    dash:editor dash:URIEditor ;
    dash:viewer dash:LabelViewer ;
    sh:defaultValue <http://purl.org/NET/rdflicense/cc-zero1.0>;
    sh:order 6 ;
  ], [
    sh:path dct:rights ;
    sh:nodeKind sh:IRI ;
    sh:maxCount 1 ;
    dash:editor dash:URIEditor ;
    dash:viewer dash:LabelViewer ;
    sh:order 7 ;
  ] ;
  sh:targetClass fdp:MetadataService .
',
        ARRAY ['http://www.w3.org/ns/dcat#Resource', 'http://www.w3.org/ns/dcat#DataService', 'https://w3id.org/fdp/fdp-o#MetadataService'],
        'INTERNAL',
        NULL,
        NULL,
        'LATEST',
        FALSE,
        FALSE,
        NULL,
        NULL,
        NOW(),
        NOW());
INSERT INTO metadata_schema_extension (uuid, metadata_schema_version_id, extended_metadata_schema_id, order_priority)
VALUES ('8742361b-cd00-4167-b859-e45fa36d0cb7', '36b22b70-6203-4dd2-9fb6-b39a776bf467', 'a5259600-a7a1-4d1c-b3bd-77a9a7a64d2c', 0);

-- FAIR Data Point
INSERT INTO metadata_schema (uuid, created_at, updated_at)
VALUES ('a92958ab-a414-47e6-8e17-68ba96ba3a2b', NOW(), NOW());
INSERT INTO metadata_schema_version (uuid, metadata_schema_id, previous_version_id, version, name, description,
                                     definition, target_classes, type, origin, imported_from, state, published,
                                     abstract, suggested_resource_name, suggested_url_prefix, created_at, updated_at)
VALUES ('4e64208d-f102-45a0-96e3-17b002e6213e',
        'a92958ab-a414-47e6-8e17-68ba96ba3a2b',
        NULL,
        '1.0.0',
        'FAIR Data Point',
        '',
        '@prefix :         <http://fairdatapoint.org/> .
@prefix dash:     <http://datashapes.org/dash#> .
@prefix dct:      <http://purl.org/dc/terms/> .
@prefix fdp:      <https://w3id.org/fdp/fdp-o#> .
@prefix sh:       <http://www.w3.org/ns/shacl#> .
@prefix xsd:      <http://www.w3.org/2001/XMLSchema#> .

:FDPShape a sh:NodeShape ;
  sh:targetClass fdp:FAIRDataPoint ;
  sh:property [
    sh:path dct:title ;
    sh:nodeKind sh:Literal ;
    sh:minCount 1 ;
    sh:maxCount  1 ;
    dash:editor dash:TextFieldEditor ;
    sh:order 1 ;
  ], [
    sh:path dct:description ;
    sh:nodeKind sh:Literal ;
    sh:maxCount 1 ;
    dash:editor dash:TextAreaEditor ;
    sh:order 2 ;
  ], [
    sh:path dct:publisher ;
    sh:node :AgentShape ;
    sh:minCount 1 ;
    sh:maxCount 1 ;
    dash:editor dash:BlankNodeEditor ;
    sh:order 3 ;
  ], [
    sh:path dcat:version ;
    sh:name "version" ;
    sh:nodeKind sh:Literal ;
    sh:minCount 1 ;
    sh:maxCount 1 ;
    dash:editor dash:TextFieldEditor ;
    dash:viewer dash:LiteralViewer ;
    sh:order 4 ;
  ], [
    sh:path dct:language ;
    sh:nodeKind sh:IRI ;
    sh:maxCount 1 ;
    dash:editor dash:URIEditor ;
    dash:viewer dash:LabelViewer ;
    sh:defaultValue <http://id.loc.gov/vocabulary/iso639-1/en> ;
    sh:order 5 ;
  ], [
    sh:path dct:license ;
    sh:nodeKind sh:IRI ;
    sh:maxCount 1 ;
    dash:editor dash:URIEditor ;
    dash:viewer dash:LabelViewer ;
    sh:defaultValue <http://purl.org/NET/rdflicense/cc-zero1.0>;
    sh:order 6 ;
  ], [
    sh:path dct:rights ;
    sh:nodeKind sh:IRI ;
    sh:maxCount 1 ;
    dash:editor dash:URIEditor ;
    dash:viewer dash:LabelViewer ;
    sh:order 7 ;
  ], [
    sh:path fdp:startDate ;
    sh:datatype xsd:dateTime ;
    sh:maxCount 1 ;
    dash:editor dash:DatePickerEditor ;
    dash:viewer dash:LiteralViewer ;
    sh:order 40 ;
  ] , [
    sh:path fdp:endDate ;
    sh:datatype xsd:dateTime ;
    sh:maxCount 1 ;
    dash:editor dash:DatePickerEditor ;
    dash:viewer dash:LiteralViewer ;
    sh:order 41 ;
  ] , [
    sh:path fdp:uiLanguage ;
    sh:nodeKind sh:IRI ;
    sh:maxCount 1 ;
    sh:defaultValue <http://id.loc.gov/vocabulary/iso639-1/en>;
    dash:editor dash:URIEditor ;
    dash:viewer dash:LabelViewer ;
    sh:order 42 ;
  ] , [
    sh:path fdp:metadataIdentifier ;
    sh:nodeKind sh:IRI ;
    sh:maxCount 1 ;
    dash:editor dash:URIEditor ;
    dash:viewer dash:LabelViewer ;
    sh:order 43 ;
  ] , [
    sh:path fdp:metadataIssued ;
    sh:datatype xsd:dateTime ;
    sh:maxCount 1 ;
    dash:viewer dash:LiteralViewer ;
    sh:order 44 ;
  ] , [
    sh:path fdp:metadataModified ;
    sh:datatype xsd:dateTime ;
    sh:maxCount 1 ;
    dash:viewer dash:LiteralViewer ;
    sh:order 45 ;
  ] .
        ',
        ARRAY ['http://www.w3.org/ns/dcat#Resource', 'http://www.w3.org/ns/dcat#DataService', 'https://w3id.org/fdp/fdp-o#MetadataService', 'https://w3id.org/fdp/fdp-o#FAIRDataPoint'],
        'INTERNAL',
        NULL,
        NULL,
        'LATEST',
        FALSE,
        FALSE,
        NULL,
        NULL,
        NOW(),
        NOW());
INSERT INTO metadata_schema_extension (uuid, metadata_schema_version_id, extended_metadata_schema_id, order_priority)
VALUES ('afebd441-8aa5-464d-bc3c-033f175449b4', '4e64208d-f102-45a0-96e3-17b002e6213e', '6f7a5a76-6185-4bd0-9fe9-62ecc90c9bad', 0);

