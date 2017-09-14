require_dependency("issues_helper")

module RedmineSubtaskListAccordion
  module Patches
    module IssuesHelperPatch
      extend ActiveSupport::Concern

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
