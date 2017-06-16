module SubtaskListAccordionHelperPatch

  def self.apply
    IssuesHelper.include self unless IssuesHelper < self
  end

  def expand_tree_at_first?(issue, user)
    if issue.descendants.visible.count <= user.pref.subtasks_default_expand_limit_upper
      return true
    else
      return false
    end
  end

  def has_grandson_issues?(issue)
    return issue.descendants.visible.where(["issues.parent_id <> ?", issue.id]).count > 0
  end
end
