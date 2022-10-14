module ProjectsControllerPatch
  def self.included(base)
    base.class_eval do
      before_action :check_for_default_module, only: [:show]
      before_action :update_active_modules, only: [:settings]

      def check_for_default_module
        @project.custom_field_values.each do |field|
          params[:jump] = field if field.custom_field.name == 'Project Default Module' and field != ''
        end
      end

      def update_active_modules
        field = ProjectCustomField.where(:name => 'Project Default Module').first
        field.possible_values = Redmine::MenuManager.items(:project_menu).map { |p| p.name.to_s }
        field.save
      end
    end
  end
end
