require "subtask_list_accordion_hook"
require "subtask_list_accordion_helper_patch"

Rails.configuration.to_prepare do
  SubtaskListAccordionUserPreferencePatch.apply
end

Redmine::Plugin.register :redmine_subtask_list_accordion do
  name 'Redmine Subtask List Accordion plugin'
  author 'Ryuta Tobita'
  description 'This plugin provide accordion to subtask list of issue.'
  version '1.3.2'
  url 'https://github.com/GEROMAX/redmine_subtask_list_accordion'
  author_url 'https://github.com/GEROMAX'
end
