class SubtaskListAccordionHook < Redmine::Hook::ViewListener
  render_on :view_issues_show_description_bottom, :partial => 'issues/subtask_list_accordion_partial'
  render_on :view_my_account_preferences, :partial => 'my/subtask_list_accordion_preferences'
  
  def view_issues_context_menu_start(context={})
    if isIssuePage?(context[:back])
      context[:controller].send(:render_to_string, {
        :partial => "context_menus/accordion_menu",
        :locals => context
      })
    end
  end
  
  private
  def isIssuePage?(path)
    path =~ Regexp.new("issues/+[0-9]")
  end
end
