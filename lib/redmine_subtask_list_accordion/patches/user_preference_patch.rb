require_dependency 'user_preference'

module RedmineSubtaskListAccordion
  module Patches
    module UserPreferencePatch

      def self.prepended(base)
        base.send(:include, InstanceMethods)
        base.class_eval do
          if defined? safe_attributes
            safe_attributes :subtasks_default_expand_limit_upper
          end
        end
      end
      
      module InstanceMethods
        def subtasks_default_expand_limit_upper; (self[:subtasks_default_expand_limit_upper] || 0).to_i; end
        def subtasks_default_expand_limit_upper=(val); self[:subtasks_default_expand_limit_upper] = val; end
      end
    end
  end
end

base = UserPreference
patch = RedmineSubtaskListAccordion::Patches::UserPreferencePatch
base.send(:prepend, patch) unless base.included_modules.include?(patch)
