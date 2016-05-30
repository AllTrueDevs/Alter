module Errorable
  def form_errors(type)
    errors = self.errors.full_messages
    if type == :request
      nested_errors = self.required_items.map{ |item| item.errors.full_messages }.uniq
    else
      nested_errors = self.accepted_items.map{ |item| item.errors.full_messages }.uniq
    end
    errors = [*errors, *nested_errors]
    errors.reject(&:empty?).join("\r\n")
  end


  private


  def has_duplicates?(type)
    if type == :required_items
      copy = self.request.required_items.find_by_category_id(self.category_id)
    else
      copy = self.decision.accepted_items.find_by_required_item_id(self.required_item_id)
    end
    copy.present? && copy != self
  end
end