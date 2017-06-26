module SubtaskListAccordionUserPreferencePatch
  def self.apply
    UserPreference.prepend self unless UserPreference < self
  end

  def subtasks_default_expand_limit_upper
    (self[:subtasks_default_expand_limit_upper] || 0).to_i
  end

  def subtasks_default_expand_limit_upper=(val)
    self[:subtasks_default_expand_limit_upper] = val
  end
end
