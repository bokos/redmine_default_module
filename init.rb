Redmine::Plugin.register :redmine_default_module do
  name 'Default Module'
  author 'Nazar Hussain'
  description 'Choose default module for redmine projects'
  version '0.0.1'
  url 'https://github.com/nazarhussain/redmine_default_module'
  author_url 'http://microgigz.com'

  unless ProjectCustomField.exists?(:name => 'Project Default Module')
    ProjectCustomField.create(
        :name => 'Project Default Module',
        :field_format => 'list',
        :possible_values => Redmine::MenuManager.items(:project_menu).map { |p| p.name.to_s },
        :regexp => '',
        :min_length => nil,
        :max_length => nil,
        :is_required => false,
        :is_for_all => false,
        :is_filter => false,
        :position => 1,
        :searchable => false,
        :default_value => '',
        :editable => false,
        :visible => true,
        :multiple => false,
        :format_store => {:url_pattern => '', :edit_tag_style => ''},
        :description => 'Custom filed to store default module'
    )
  end

  ProjectsController.include ProjectsControllerPatch
end
