# OpenSKOS

A Ruby client for searching and retrieving SKOS concepts from an OpenSKOS 
instance over its RESTful API.

## Installation

Add this line to your application's Gemfile:

    gem 'openskos'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install openskos

## Configuration

Set the base URL of the OpenSKOS instance you wish to query:

    OpenSKOS.url = "http://skos.example.com/"

## Usage

### Search for concepts

Search for concepts containing the term "history":

    OpenSKOS::Concept.find("history")

Pagination of results uses the standard Solr parameters *start* and *rows*:

    OpenSKOS::Concept.find("history", :start => 51, :rows => 50)

### Retrieve a concept

Retrieve a concept by its URI:

    OpenSKOS::Concept.find(URI.parse("http://skos.example.com/concept/history"))

Retrieve a concept by its UUID:

    OpenSKOS::Concept.find("0a39cbfc-a491-75f8-60b2-6b50418e299d")

### Response formats

By default, responses from the OpenSKOS API are RDF/XML, returned as a parsed
`Nokogiri::XML::Document`.

To request JSON, returned as a parsed Hash, add `:format => "json"` to the
parameters hash passed to `OpenSKOS::Concept.find`:

    OpenSKOS::Concept.find("physics", :format => "json")

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
