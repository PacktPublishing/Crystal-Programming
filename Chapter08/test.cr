require "xml"

xml = <<-XML
<?xml version="1.0"?>
<foo xmlns="urn:oasis:names:tc:SAML:2.0:metadata" xmlns:a="http://www.w3.org/1999/xhtml">bar</foo>
XML

document = XML.parse(xml)
person = document.first_element_child.not_nil!
pp person.namespaces
pp person.namespace_scopes
