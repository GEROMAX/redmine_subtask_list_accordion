require_dependency "subtask_list_accordion_hook"
require_dependency "subtask_list_accordion_helper_patch"
require_dependency "subtask_list_accordion_controller_patch"

Redmine::Plugin.register :redmine_subtask_list_accordion do
  name 'Redmine Subtask List Accordion plugin'
  author 'Ryuta Tobita'
  description 'This plugin provide accordion to subtask list of issue.'
  version '1.3.1'
  url 'https://github.com/GEROMAX/redmine_subtask_list_accordion'
  author_url 'https://github.com/GEROMAX'
end
