# Orthotypo

[![Maintainability](https://api.codeclimate.com/v1/badges/16eb1f100538684deee0/maintainability)](https://codeclimate.com/github/noesya/orthotypo/maintainability)

Il y a un corpus riche de règles typographiques, dépendant des langues. 
Cette gem vise à intégrer ces règles et à automatiser leurs mises en application pour le web, quand cela est possible.
La version 1 créait des effets de bord, en tentant d'implémenter trop de logiques.
La version 2 est beaucoup plus modeste.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add orthotypo

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install orthotypo

## Usage

Remplacement d'espace par un espace insécable avant les signes doubles.

```
"Un texte avec un espace devant un signe double : mais il manque l'espace insécable.".ortho
> Un texte avec un espace devant un signe double : mais il manque l'espace insécable.
```

## Tests

```
rake
```

```
bundle exec rspec
```

Pour jouer un seul test : 
```
bundle exec rspec ./spec/composer/fr_spec.rb:56
```

## Sources

- https://fr.wikipedia.org/wiki/Code_typographique
- http://www.orthotypographie.fr/
- https://www.scribbr.fr/elements-linguistiques/les-espaces/

## Development

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/noesya/orthotypo. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/orthotypo/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Orthotypo project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/orthotypo/blob/main/CODE_OF_CONDUCT.md).
