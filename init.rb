require_dependency 'redmine_subtask_list_accordion/hooks/subtask_list_accordion_hook'
require_dependency 'redmine_subtask_list_accordion/patches/issues_helper_patch'
require_dependency 'redmine_subtask_list_accordion/patches/user_preference_patch'

reloader = defined?(ActiveSupport::Reloader) ? ActiveSupport::Reloader : ActionDispatch::Reloader
reloader.to_prepare do
  unless UserPreference.included_modules.include?(RedmineSubtaskListAccordion::Patches::UserPreferencePatch)
    UserPreference.send :prepend, RedmineSubtaskListAccordion::Patches::UserPreferencePatch
  end

  unless IssuesHelper.included_modules.include?(RedmineSubtaskListAccordion::Patches::IssuesHelperPatch)
    IssuesHelper.send :include, RedmineSubtaskListAccordion::Patches::IssuesHelperPatch
  end
end

Redmine::Plugin.register :redmine_subtask_list_accordion do
  name 'Redmine Subtask List Accordion plugin'
  author 'Ryuta Tobita'
  description 'This plugin provide accordion to subtask list of issue.'
  version '2.1.0'
  url 'https://github.com/GEROMAX/redmine_subtask_list_accordion'
  author_url 'https://github.com/GEROMAX'
  settings default: { 'enable_server_scripting_mode' => true }, :partial => 'settings/subtask_list_accordion_settings'
end
