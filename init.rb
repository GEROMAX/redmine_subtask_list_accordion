require_dependency 'redmine_subtask_list_accordion/hooks/subtask_list_accordion_hook'
require_dependency 'redmine_subtask_list_accordion/patches/issues_helper_patch'
require_dependency 'redmine_subtask_list_accordion/patches/user_preference_patch'

ActionDispatch::Callbacks.to_prepare do
  unless UserPreference.included_modules.include?(RedmineSubtaskListAccordion::Patches::UserPreferencePatch)
    UserPreference.send :prepend, RedmineSubtaskListAccordion::Patches::UserPreferencePatch
  end

  unless IssuesHelper.included_modules.include?(RedmineSubtaskListAccordion::Patches::IssuesHelperPatch)
    IssuesHelper.send :prepend, RedmineSubtaskListAccordion::Patches::IssuesHelperPatch
  end
end

Redmine::Plugin.register :redmine_subtask_list_accordion do
  name 'Redmine Subtask List Accordion plugin'
  author 'Ryuta Tobita'
  description 'This plugin provide accordion to subtask list of issue.'
  version '1.3.3'
  url 'https://github.com/GEROMAX/redmine_subtask_list_accordion'
  author_url 'https://github.com/GEROMAX'
end
