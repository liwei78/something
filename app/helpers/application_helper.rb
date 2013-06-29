module ApplicationHelper
  def m(amount)
    "$ #{amount.round(2)}"
  end
end
