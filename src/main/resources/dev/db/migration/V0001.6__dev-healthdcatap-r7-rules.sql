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
-- Resource 1.1.0
UPDATE metadata_schema_version
SET state      = 'LEGACY',
    updated_at = NOW()
WHERE uuid = 'ad9f1c05-ab5c-459d-aefa-c0a4f4be2d6f';
INSERT INTO metadata_schema_version (uuid, metadata_schema_id, previous_version_id, version, name, description,
                                     definition, target_classes, type, origin, imported_from, state, published,
                                     abstract, suggested_resource_name, suggested_url_prefix, created_at, updated_at)
VALUES ('c3a7e2f1-5b8d-4e6a-9f2c-7d1b4a8e6c30',
        'ab3ce955-c4c5-4bbe-b295-501116d4301e',
        'ad9f1c05-ab5c-459d-aefa-c0a4f4be2d6f',
        '1.1.0',
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
@prefix cv: <http://data.europa.eu/m8g/> .
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
    dash:viewer dash:LabelViewer ;
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
  ], [
    # Agent Contact Details aligned with Contact Point
    rdfs:seeAlso "https://healthdataeu.pages.code.europa.eu/healthdcat-ap/releases/release-7/changelog.html";
    shacl:path cv:contactPoint ;
    shacl:name "Contact point (CPOV)"@en ;
    shacl:description "Contact details for the agent, using the CPOV contact point model."@en ;
    shacl:class cv:ContactPoint ;
    shacl:node :CPOVContactPointShape ;
    shacl:maxCount 1 ;
    shacl:nodeKind shacl:BlankNodeOrIRI ;
    dash:editor dash:BlankNodeEditor ;
    dash:viewer dash:DetailsViewer
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
        shacl:nodeKind shacl:IRI ;
        dash:editor dash:URIEditor ;
        dash:viewer dash:LabelViewer ;
    ], [
        shacl:name "Email" ;
        shacl:description "An e-mail address as a mailto: IRI, e.g. mailto:contact@example.org"@en ;
        shacl:path vcard:hasEmail ;
        shacl:maxCount 1 ;
        shacl:nodeKind shacl:IRI ;
        dash:editor dash:URIEditor ;
        dash:viewer dash:LabelViewer ;
    ] ;
    shacl:or (
        [ shacl:path vcard:hasURL ; shacl:minCount 1 ]
        [ shacl:path vcard:hasEmail ; shacl:minCount 1 ]
    ) ;
    shacl:message "A contact point (vcard:Kind) needs at least one of vcard:hasURL or vcard:hasEmail (HealthDCAT-AP R7)."@en .

# Contact Point CPOV
:CPOVContactPointShape a shacl:NodeShape ;
  rdfs:seeAlso "https://semiceu.github.io/CPOV/releases/2.1.1/#ContactPoint" ;
  shacl:closed false ;
  shacl:targetClass cv:ContactPoint ;
  shacl:property [
      shacl:path cv:email ;
      shacl:name "Email"@en ;
      shacl:description "E-mail address of the contact point. R7 issue #25: a plain literal, not a mailto: IRI."@en ;
      shacl:nodeKind shacl:Literal ;
      dash:editor dash:TextFieldEditor ;
      dash:viewer dash:LiteralViewer ;
      shacl:order 1
    ], [
      shacl:path cv:contactPage ;
      shacl:name "Contact page"@en ;
      shacl:description "A web page giving access to the contact point."@en ;
      shacl:nodeKind shacl:IRI ;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:order 2
    ], [
      shacl:path cv:telephone ;
      shacl:name "Telephone"@en ;
      shacl:description "Telephone number of the contact point."@en ;
      shacl:nodeKind shacl:Literal ;
      dash:editor dash:TextFieldEditor ;
      dash:viewer dash:LiteralViewer ;
      shacl:order 3
    ], [
      shacl:path cv:openingHours ;
      shacl:name "Opening hours"@en ;
      shacl:description "The hours during which the contact point is available."@en ;
      shacl:nodeKind shacl:BlankNodeOrIRI ;
      dash:editor dash:BlankNodeEditor ;
      dash:viewer dash:DetailsViewer ;
      shacl:order 4
    ], [
      shacl:path cv:specialOpeningHoursSpecification ;
      shacl:name "Availability restriction"@en ;
      shacl:description "Exceptions to the regular opening hours."@en ;
      shacl:nodeKind shacl:BlankNodeOrIRI ;
      dash:editor dash:BlankNodeEditor ;
      dash:viewer dash:DetailsViewer ;
      shacl:order 5
    ] ;
  shacl:or (
    [ shacl:path cv:email ; shacl:minCount 1 ]
    [ shacl:path cv:contactPage ; shacl:minCount 1 ]
  ) ;
  shacl:message "A contact point (cv:ContactPoint) needs at least one of cv:email or cv:contactPage (HealthDCAT-AP R7)."@en .

# Custodian
:CustodianShape a shacl:NodeShape ;
  rdfs:seeAlso "https://healthdataeu.pages.code.europa.eu/healthdcat-ap/releases/release-7/#custodian" ;
  shacl:closed false ;
  shacl:property [
      shacl:path foaf:name ;
      shacl:name "Name"@en ;
      shacl:description "A name of the custodian."@en ;
      shacl:minCount 1 ;
      shacl:nodeKind shacl:Literal ;
      dash:editor dash:TextFieldEditor ;
      dash:viewer dash:LiteralViewer ;
      shacl:order 1
    ], [
      shacl:path dc:type ;
      shacl:name "Type"@en ;
      shacl:description "The nature of the custodian. The NAL Health Publisher Types (EHDS) must be used."@en ;
      shacl:maxCount 1 ;
      shacl:nodeKind shacl:BlankNodeOrIRI ;
      dash:editor dash:URIEditor ;
      dash:viewer dash:LabelViewer ;
      shacl:order 2
    ], [
      shacl:path cv:contactPoint ;
      shacl:name "Contact point (CPOV)"@en ;
      shacl:description "Contact details for technical support from the data holder."@en ;
      shacl:class cv:ContactPoint ;
      shacl:node :CPOVContactPointShape ;
      shacl:minCount 1 ;
      shacl:maxCount 1 ;
      shacl:nodeKind shacl:BlankNodeOrIRI ;
      dash:editor dash:BlankNodeEditor ;
      dash:viewer dash:DetailsViewer ;
      shacl:order 3
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
        shacl:path dc:type ;
        shacl:name "Type" ;
        shacl:nodeKind shacl:BlankNodeOrIRI ;
        shacl:maxCount 1 ;
        dash:editor dash:URIEditor ;
        dash:viewer dash:LabelViewer ;
    ], [
        shacl:path cv:contactPoint ;
        shacl:name "Contact point (CPOV)" ;
        shacl:class cv:ContactPoint ;
        shacl:node :CPOVContactPointShape ;
        shacl:minCount 1 ;
        shacl:maxCount 1 ;
        shacl:nodeKind shacl:BlankNodeOrIRI ;
        dash:editor dash:BlankNodeEditor ;
        dash:viewer dash:DetailsViewer ;
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
    dash:editor dash:TextAreaEditor ;
    dash:viewer dash:LiteralViewer ;
  ], [
    # healthdcatap:publisherType does not exist anymore
    shacl:path dc:type ;
    shacl:name "Publisher type"@en ;
    shacl:maxCount 1 ;
    shacl:nodeKind shacl:IRI ;
    dash:editor dash:URIEditor ;
    dash:viewer dash:LabelViewer ;
  ], [
    # Contact point (cv:ContactPoint) cardinality 1
    shacl:path cv:contactPoint ;
    shacl:name "Contact point (CPOV)"@en ;
    shacl:class cv:ContactPoint ;
    shacl:node :CPOVContactPointShape ;
    shacl:minCount 1 ;
    shacl:maxCount 1 ;
    shacl:nodeKind shacl:BlankNodeOrIRI ;
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


-- >>> File: dataset.sql
-- Dataset 1.1.0
UPDATE metadata_schema_version
SET state      = 'LEGACY',
    updated_at = NOW()
WHERE uuid = '5f10b562-441e-4057-bc2e-ec1cc299ae46';
INSERT INTO metadata_schema_version (uuid, metadata_schema_id, previous_version_id, version, name, description,
                                     definition, target_classes, type, origin, imported_from, state, published,
                                     abstract, suggested_resource_name, suggested_url_prefix, created_at, updated_at)
VALUES ('e8b4d6a2-1c7f-4a9e-b3d5-2f6c8a1e9b47',
        '4ecfe85e-d30a-4bcf-b125-1c6fee52683b',
        '5f10b562-441e-4057-bc2e-ec1cc299ae46',
        '1.1.0',
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
@prefix dpv: <https://w3id.org/dpv#> .
@prefix dqv: <http://www.w3.org/ns/dqv#> .
@prefix geodcatap: <http://data.europa.eu/930/> .
@prefix cv: <http://data.europa.eu/m8g/> .

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
      shacl:group :DatasetOptionalSection;
  shacl:order 1;
  # R7 PUBLIC access level: type is 0..*
  rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Dataset.type";
      shacl:description "A type of the Dataset."@en;
      shacl:name "type"@en;
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
      shacl:group :DatasetOptionalSection;
  shacl:order 1;
  # R7 PUBLIC access level: keyword is 0..*
  rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Dataset.keyword";
      shacl:description "A keyword or tag describing the Dataset."@en;
      shacl:name "keyword"@en;
      shacl:nodeKind shacl:Literal;
      dash:editor dash:TextFieldEditor;
      dash:viewer dash:LiteralViewer;
      shacl:path dcat:keyword
    ], [
      shacl:group :DatasetOptionalSection;
  shacl:order 1;
  # R7 PUBLIC access level: provenance is 0..*
  rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Dataset.provenance";
      shacl:description "A statement about the lineage of a Dataset."@en;
      shacl:name "provenance"@en;
      # HealthDCAT-AP R7 takes a dct:ProvenanceStatement carrying the text as rdfs:label, rather than a bare literal.
      shacl:class dc:ProvenanceStatement;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:BlankNodeEditor;
      dash:viewer dash:DetailsViewer;
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
      shacl:group :DatasetOptionalSection;
  shacl:order 1;
  # R7 PUBLIC access level: contact point is 0..*
  rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Dataset.contactpoint";
      shacl:class vcard:Kind;
      shacl:description "Contact information that can be used for sending comments about the Dataset."@en;
      shacl:name "contact point"@en;
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
      # R7: variables is 0..*
      shacl:group :DatasetOptionalSection;
  shacl:order 1;
  rdfs:seeAlso "https://healthdataeu.pages.code.europa.eu/healthdcat-ap/releases/release-7/#healthdcataphasVariables";
      shacl:description "Links the Dataset to a CSVW TableGroup describing its variables. Becomes mandatory when structured data is true."@en;
      shacl:name "variables"@en;
      shacl:nodeKind shacl:IRI;
      dash:editor dash:URIEditor;
      dash:viewer dash:LabelViewer;
      shacl:path healthdcatap:hasVariables
    ], [
      shacl:group :DatasetOptionalSection;
      shacl:order 1;
      rdfs:seeAlso "https://healthdataeu.pages.code.europa.eu/healthdcat-ap/releases/release-7/";
      shacl:description "A code value used in the dataset, as free text."@en;
      shacl:name "code values"@en;
      shacl:nodeKind shacl:Literal;
      dash:editor dash:TextFieldEditor;
      dash:viewer dash:LiteralViewer;
      shacl:path healthdcatap:hasCodeValues
    ], [
      shacl:group :DatasetOptionalSection;
      shacl:order 1;
      rdfs:seeAlso "https://hdeu-dcat.acceptance.data.health.europa.eu/resource/authority/coding-system";
      # Membership of the EU coding-system list is knowingly NOT enforced
      shacl:class dc:Standard;
      shacl:description "A coding system used in the dataset."@en;
      shacl:name "coding system"@en;
      shacl:nodeKind shacl:IRI;
      dash:editor dash:URIEditor;
      dash:viewer dash:LabelViewer;
      shacl:path healthdcatap:hasCodingSystem
    ], [
      shacl:group :DatasetOptionalSection;
      shacl:order 1;
      shacl:class dpv:PersonalData;
      shacl:description "A category of personal data contained in the dataset (DPV-PD)."@en;
      shacl:name "personal data"@en;
      shacl:nodeKind shacl:IRI;
      dash:editor dash:URIEditor;
      dash:viewer dash:LabelViewer;
      shacl:path dpv:hasPersonalData
    ], [
      shacl:group :DatasetOptionalSection;
      shacl:order 1;
      # R7: purpose is 0..*
      shacl:class dpv:Purpose;
      shacl:description "The purpose for which the data are processed."@en;
      shacl:name "purpose"@en;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:BlankNodeEditor;
      dash:viewer dash:DetailsViewer;
      shacl:path dpv:hasPurpose
    ], [
      shacl:group :DatasetOptionalSection;
      shacl:order 1;
      # R7: legal basis is 0..*
      shacl:class dpv:LegalBasis;
      shacl:description "The legal ground on which the data are processed."@en;
      shacl:name "legal basis"@en;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:BlankNodeEditor;
      dash:viewer dash:DetailsViewer;
      shacl:path dpv:hasLegalBasis
    ], [
      shacl:group :DatasetOptionalSection;
      shacl:order 1;
      # R7: quality annotation is 0..*
      shacl:class dqv:QualityCertificate;
      shacl:description "A quality annotation attached to the dataset."@en;
      shacl:name "quality annotation"@en;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:BlankNodeEditor;
      dash:viewer dash:DetailsViewer;
      shacl:path dqv:hasQualityAnnotation
    ], [
      shacl:group :DatasetOptionalSection;
      shacl:order 1;
      # The party holding the data, distinct from the publisher
      shacl:description "The custodian of the dataset."@en;
      shacl:name "custodian"@en;
      shacl:maxCount 1;
      shacl:node :CustodianShape;
      dash:editor dash:BlankNodeEditor;
      dash:viewer dash:DetailsViewer;
      shacl:path geodcatap:custodian
    ], [
      shacl:group :DatasetOptionalSection;
      shacl:order 1;
      shacl:class dcat:Distribution;
      shacl:description "A distribution holding analytical output derived from the dataset."@en;
      shacl:name "analytics"@en;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:BlankNodeEditor;
      dash:viewer dash:DetailsViewer;
      shacl:path healthdcatap:analytics
    ], [
      shacl:group :DatasetOptionalSection;
      shacl:order 1;
      rdfs:seeAlso "https://healthdataeu.pages.code.europa.eu/healthdcat-ap/releases/release-7/#healthdcatapminTypicalAge";
      # R7: 0..1 / Recommended
      shacl:datatype xsd:nonNegativeInteger;
      shacl:description "The minimum typical age of the population within the dataset."@en;
      shacl:name "minimum typical age"@en;
      shacl:maxCount 1;
      shacl:nodeKind shacl:Literal;
      dash:editor dash:LiteralEditor;
      dash:viewer dash:LiteralViewer;
      shacl:path healthdcatap:minTypicalAge
    ], [
      shacl:group :DatasetOptionalSection;
      shacl:order 1;
      # R7: 0..1 / Recommended
      shacl:datatype xsd:nonNegativeInteger;
      shacl:description "The maximum typical age of the population within the dataset."@en;
      shacl:name "maximum typical age"@en;
      shacl:maxCount 1;
      shacl:nodeKind shacl:Literal;
      dash:editor dash:LiteralEditor;
      dash:viewer dash:LiteralViewer;
      shacl:path healthdcatap:maxTypicalAge
    ], [
      shacl:group :DatasetOptionalSection;
      shacl:order 1;
      # R7: 0..1 / Recommended
      shacl:datatype xsd:nonNegativeInteger;
      shacl:description "The number of records within the dataset."@en;
      shacl:name "number of records"@en;
      shacl:maxCount 1;
      shacl:nodeKind shacl:Literal;
      dash:editor dash:LiteralEditor;
      dash:viewer dash:LiteralViewer;
      shacl:path healthdcatap:numberOfRecords
    ], [
      shacl:group :DatasetOptionalSection;
      shacl:order 1;
      # R7: 0..1 / Recommended
      shacl:datatype xsd:nonNegativeInteger;
      shacl:description "The number of unique individuals within the dataset."@en;
      shacl:name "number of unique individuals"@en;
      shacl:maxCount 1;
      shacl:nodeKind shacl:Literal;
      dash:editor dash:LiteralEditor;
      dash:viewer dash:LiteralViewer;
      shacl:path healthdcatap:numberOfUniqueIndividuals
    ], [
      shacl:group :DatasetOptionalSection;
      shacl:order 1;
      # R7: 0..* / Recommended
      shacl:description "The populations covered by the dataset."@en;
      shacl:name "population coverage"@en;
      shacl:nodeKind shacl:Literal;
      dash:editor dash:TextAreaEditor;
      dash:viewer dash:LiteralViewer;
      shacl:path healthdcatap:populationCoverage
    ], [
      shacl:group :DatasetOptionalSection;
      shacl:order 1;
      # R7: 0..1 / Recommended, range Period of Time
      shacl:class dc:PeriodOfTime;
      shacl:description "The minimum and maximum retention time of the dataset."@en;
      shacl:name "retention period"@en;
      shacl:maxCount 1;
      shacl:node :PeriodOfTimeShape;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:BlankNodeEditor;
      dash:viewer dash:DetailsViewer;
      shacl:path healthdcatap:retentionPeriod
    ], [
      shacl:group :DatasetOptionalSection;
      shacl:order 1;
      rdfs:seeAlso "https://semiceu.github.io/DCAT-AP/releases/3.0.1#Dataset.sample";
      # R7: 0..* / Recommended, range Distribution
      shacl:class dcat:Distribution;
      shacl:description "A sample distribution of the dataset."@en;
      shacl:name "sample"@en;
      shacl:nodeKind shacl:BlankNodeOrIRI;
      dash:editor dash:BlankNodeEditor;
      dash:viewer dash:DetailsViewer;
      shacl:path <http://www.w3.org/ns/adms#sample>
    ], [
      shacl:group :DatasetOptionalSection;
      shacl:order 1;
      # R7: 0..* / Optional.
      shacl:description "An alternative name for the Dataset."@en;
      shacl:name "alternative"@en;
      shacl:nodeKind shacl:Literal;
      dash:editor dash:TextFieldEditor;
      dash:viewer dash:LiteralViewer;
      shacl:path dc:alternative
    ];
  shacl:or (
    [ shacl:not [ shacl:path dc:accessRights ;
                  shacl:hasValue <http://publications.europa.eu/resource/authority/access-right/NON_PUBLIC> ] ]
    [ shacl:property [ shacl:path dcat:contactPoint ; shacl:minCount 1 ] ,
                     [ shacl:path dcat:keyword ; shacl:minCount 1 ] ,
                     [ shacl:path dc:type ; shacl:minCount 1 ] ,
                     [ shacl:path dc:provenance ; shacl:minCount 1 ] ]
  ) ;
  shacl:message "A NON_PUBLIC dataset needs at least one dcat:contactPoint, dcat:keyword, dct:type and dct:provenance (HealthDCAT-AP R7)."@en ;
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
INSERT INTO metadata_schema_extension (uuid, metadata_schema_version_id, extended_metadata_schema_id, order_priority) VALUES ('9a2f5c8e-3d1b-4e7a-8c6f-4b9d2e7a1f53', 'e8b4d6a2-1c7f-4a9e-b3d5-2f6c8a1e9b47', 'ab3ce955-c4c5-4bbe-b295-501116d4301e', 0);
