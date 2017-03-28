require_dependency 'my_controller'

module SubtaskListAccordionControllerPatch
  def self.included(base) # :nodoc:
    base.send(:include, InstanceMethods)

    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development

      alias_method_chain :account, :subtask_list_option
    end
  end

  module InstanceMethods
    def account_with_subtask_list_option
      account = account_without_subtask_list_option
      User.safe_attributes 'subtasks_default_expand_limit_upper'
      return account
    end
  end
end

MyController.send(:include, SubtaskListAccordionControllerPatch)
