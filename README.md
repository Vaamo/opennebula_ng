# opennebula\_ng-cookbook

A cookbook for managing [OpenNebula](http://opennebula.org/) via the Chef configuration management tool.

## Supported Platforms


## Attributes

## Usage

### opennebula\_ng::default

Include `opennebula_ng` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[opennebula_ng::default]"
  ]
}
```

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (i.e. `add-new-recipe`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request

## License

|                      |                                          |
|:---------------------|:-----------------------------------------|
| **Author:**          | Chris Aumann (<me@chr4.org>)
| **Copyright:**       | Copyright (c) 2014 Vaamo Finanz AG
| **License:**         | Apache License, Version 2.0

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
