require 'digest/sha1'
class OpenIdAuthenticatorGenerator < Rails::Generator::NamedBase


  def initialize(runtime_args, runtime_options = {})
    super 

    @model_controller_name = @name.pluralize
    base_name, @model_controller_class_path, @model_controller_file_path, @model_controller_class_nesting, @model_controller_class_nesting_depth = extract_modules(@model_controller_name)
    @model_controller_class_name_without_nesting, @model_controller_singular_name, @model_controller_plural_name = inflect_names(base_name)

    if @model_controller_class_nesting.empty?
      @model_controller_class_name = @model_controller_class_name_without_nesting
    else
      @model_controller_class_name = "#{@model_controller_class_nesting}::#{@model_controller_class_name_without_nesting}"
    end
    @model_controller_routing_name    = @table_name
    @model_controller_routing_path    = @model_controller_file_path
    @model_controller_controller_name = @model_controller_plural_name


  end

  def manifest
    recorded_session = record do |m|
        m.migration_template 'migration.rb', 'db/migrate', :assigns => {
          :migration_name => "AddOpenIdAuthenticatorToUsers"
        }, :migration_file_name => "add_open_id_authenticator_to_users"
    end
    recorded_session
  end

end