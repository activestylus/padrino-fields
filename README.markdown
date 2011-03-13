# PadrinoFields

Forms made easy for the **[Padrino Framework](http://www.padrinorb.com)**

Takes the pain out of building forms. Generates inputs, labels and field hints with a minimal and flexible DSL. Currently only supports **[DataMapper](http://datamapper.org/)**, but plugging more ORMs in will be trivial due to modular design (See below)

## Installation

Install the gem:

    gem install padrino-fields

Add it to your Gemfile:

    gem "padrino-fields"

## Basic Usage

The heart of **PadrinoFields** is the **:input** method

    - form_for @user do |f|
      = f.input :username
      = f.input :password
      = f.submit

This will generate a form with labels for username and password - supplying the appropriate inputs, labels and error messages on missing/invalid fields. **PadrinoFields** looks at your database columns to generate default inputs.

## Available Inputs

 Mapping       | Input            | Column Type                          |
:--------------|:-----------------|:-------------------------------------|
 **:boolean**  | check box        | boolean                              |
 **:string**   | text field       | string                               |
 **:email**    | email field      | string with name matching "email"    |
 **:url**      | url field        | string with name matching "url"      |
 **:tel**      | tel field        | string with name matching "phone"    |
 **:password** | password field   | string with name matching "password" |
 **:search**   | search           | string with name matching "search"   |
 **:text**     | text area        | text                                 |
 **:file**     | file field       | string, responding to file methods   |
 **:number**   | number field     | integer, float, decimal              |
 **:date**     | date field       | date, datetime, timestamps           |
 **:select**   | select           | -                                    |
 **:radios**   | radio buttons    | -                                    |
 **:checks**   | check boxes      | -                                    |

## Field Customization

Override the default input type like so:

    = f.input :description, :as => :text
    = f.input :joined_on,   :as => :string
    = f.accept_terms,       :as => :boolean

Add custom label text, field hints and more:

    = f.input :username, :caption => 'You will login with this name'
    = f.input :password, :hint => 'Letters and numbers only'

Disable labels, hints or errors:

    = f.input :username, :caption => false
    = f.input :password, :hint => false
    = f.input :email, :disabled => true

Pass html attribute straight to the input:

    = f.input :username, :input_html => { :class => 'special' }
    = f.input :password, :input_html => { :maxlength => 20 }
    = f.input :remember_me, :input_html => { :value => '1' }

## Validations

By default all inputs are optional. **PadrinoFields** looks at your model validations to see if a field's presence is required and will mark it by prepending a * to the label. 

    # app/models/person.rb
    class Person
      validates_presence_of :name
    
    # app/views/people/_form.haml
    = f.input :name
    

You can also do it manually with the **:required** option

    = f.input :email, :required => true

## Options / Collections

Options can be arrays or ranges, and when a **:options** is given the **:select** input will be rendered by default, so we don't need to pass the **:as => :select** option. 

    = f.input :user, :options => User.all.map(&:name)

Use ranges as options for your select tags

    = f.input :year, :options => (1950..Time.now.year)

Options may also be rendered as **:radios** and **:checks**

## Settings

You can override a few default settings by creating a lib file as follows:

    **PadrinoFields**::Settings.configure do |config|
      
      config.container = :p
      # Tag which wraps the inputs and labels
      
      config.label_required_marker = "<abbr>*</abbr>"
      # Visual indicator of a required field
      
      config.label_required_marker_position = :prepend
      # Placement of marker, either :append or :prepend (default)
      
    end


## ORM Support

So far only Datamapper is supported, but since the code is decoupled it should be relatively easy to support others:

1. Clone **padrino-fields/orms/datamapper.rb** and extend your ORM in a similar fashion
2. Clone **test/fixtures/datamapper** and substitute the models with your ORM
3. Clone **test/test_datamapper.rb** to write tests
4. Open **lib/padrino-fields/form_builder.rb**

Require your orm file and include its module as follows:

    require File.expand_path(File.dirname(__FILE__) + '/orms/mycoolorm') if defined?(MyCoolOrm)

    module Padrino
      module Helpers
        module FormBuilder
          class FieldsFormBuilder < AbstractFormBuilder #:nodoc:
        
            include **PadrinoFields**::MyCoolOrm if defined?(MyCoolOrm)

## Todo

* Add country select
* Generators for config and views
* I18n integration
* More documentation

## Bug reports

If you discover any bugs, feel free to create an issue on GitHub. Please add as much information as possible to help us fix the problem. You can be an even bigger help by forking and sending a pull request. Be sure to include tests with your code!

http://github.com/activestylus/padrino-field/issues

## Credit

This gem borrows heavily from the following projects:
* [Formtastic](http://github.com/justinfrench/formtastic)
* [**PadrinoFields**](http://github.com/plataformatec/simple_form)

Many thanks to [Justin French](https://github.com/justinfrench) and [Jose Valim](https://github.com/josevalim) for the inspiration. Extra shouts to [Nathan Esquenazi](https://github.com/nesquena) and [Davide d'Agostino](https://github.com/DAddYE) for lending a hand on the [google group](https://groups.google.com/forum/#!forum/padrino)

## License

MIT License. Copyright 2011 Steven Garcia