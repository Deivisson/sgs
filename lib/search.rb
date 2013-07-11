module Search

  SPECIAL_CHARACTER = %w(lk gt lt dg dl)

  def search(conditions)
    conditions ||= []
    query = self.scoped
    conditions.each do |k,v|
      v.delete "" if v.is_a?(Array)
      query = query.where(format_condition(k,v)) if v.present?
    end
    query
  end

private

  def format_condition(k,v)
    operator = k[-2..k.size]
    attribute = SPECIAL_CHARACTER.include?(operator) ?  k[0..-4] : k
    case operator
    when "lk" #like
      ["#{attribute} LIKE ? ","%#{v}%"]
      #["#{attribute} like ? ",v]
    when "gt" #values grather than
      ["#{attribute} >= ? ",v.to_f] if v.to_f > 0
    when "lt" #date less than
      ["#{attribute} <= ? ",v.to_f] if v.to_f > 0
    when  "dg"
      ["#{attribute} >= ? ",v.to_date] if v.present?
    when "dl" #date less than
      ["#{attribute} <= ? ",v.to_date] if v.present?
    else
      ["#{attribute} #{ v.is_a?(Array) ? ' in (?) ' : ' = ?'}",v]
    end
  end
end
