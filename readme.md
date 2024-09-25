# Tokens Studio Helm charts

This contains multiple charts assembled by the Tokens Studio team for hosting services

## Charts 

### [Go Alert](./charts/goalert/readme.md)

[Goalert](https://github.com/target/goalert) is an open source IRM solution 


## Development

### Json schema generation

We use [Helm Schema](https://github.com/socialgouv/helm-schema) to generate json schema for the values.yaml files. As such, make sure you annotate the code with JSDOC annotations as seen in the values.yaml files.

To generate the json schema for the values.yaml files run `npx @socialgouv/helm-schema -f values.yaml > values.schema.json` within each chart