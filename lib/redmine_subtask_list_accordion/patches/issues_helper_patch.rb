require_dependency("issues_helper")

module RedmineSubtaskListAccordion
  module Patches
    module IssuesHelperPatch
      extend ActiveSupport::Concern

      #wrap original method
      alias_method :original_render_descendants_tree, :render_descendants_tree
      alias_method :render_descendants_tree, :switch_render_descendants_tree
      def switch_render_descendants_tree(issue)
        if has_grandson_issues?(issue)
          render_descendants_tree_accordion(issue)
        else
          original_render_descendants_tree(issue)
        end
      end
      def render_descendants_tree_accordion(issue)
        s = '<span>NEW!</span><table class="list issues odd-even">'
        issue_list(issue.descendants.visible.preload(:status, :priority, :tracker, :assigned_to).sort_by(&:lft)) do |child, level|
          css = "issue issue-#{child.id} hascontextmenu #{child.css_classes}"
          css << " idnt idnt-#{level}" if level > 0
          s << content_tag('tr',
                 content_tag('td', check_box_tag("ids[]", child.id, false, :id => nil), :class => 'checkbox') +
                 content_tag('td', link_to_issue(child, :project => (issue.project_id != child.project_id)), :class => 'subject', :style => 'width: 50%') +
                 content_tag('td', h(child.status), :class => 'status') +
                 content_tag('td', link_to_user(child.assigned_to), :class => 'assigned_to') +
                 content_tag('td', child.disabled_core_fields.include?('done_ratio') ? '' : progress_bar(child.done_ratio), :class=> 'done_ratio'),
                 :class => css)
        end
        s << '</table>'
        s.html_safe
      end

      # add method to IssuesHelper
      def expand_tree_at_first?(issue, user)
        return issue.descendants.visible.count <= user.pref.subtasks_default_expand_limit_upper
      end

      def has_grandson_issues?(issue)
        return issue.descendants.visible.where(["issues.parent_id <> ?", issue.id]).count > 0
      end

    end
  end
end
