# Orthotypo

[![Maintainability](https://api.codeclimate.com/v1/badges/16eb1f100538684deee0/maintainability)](https://codeclimate.com/github/noesya/orthotypo/maintainability)

Il y a un corpus riche de règles typographiques, dépendant des langues. 
Cette gem vise à intégrer ces règles et à automatiser leurs mises en application pour le web, quand cela est possible.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add orthotypo

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install orthotypo

## Usage

Ajout d'espace fine insécable avant les signes doubles en français.

```
"Un texte avec un signe double: mais il manque l'espace.".ortho
> Un texte avec un signe double : mais il manque l'espace.

```

## Roadmap

### v1
Ne pas endommager l'HTML et les HTML entities (&nbsp;)

### v2
S'adapter aux locales (détecter I18n)
Permettre les configs

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
