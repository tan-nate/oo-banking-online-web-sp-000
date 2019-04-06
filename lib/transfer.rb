class Transfer
  attr_accessor :sender, :receiver, :status, :amount
  
  @@completed = []
  
  def self.completed
    @@completed
  end
  
  def initialize(sender, receiver, amount)
    @sender = BankAccount.new()
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end
  
  def valid?
    sender = BankAccount.all.find {|account| account.name == self.sender}
    receiver = BankAccount.all.find {|account| account.name == self.receiver}
    if sender == nil
      false
    elsif sender.valid? && receiver.valid? && self.sender.balance > self.amount
      true
    else
      false
    end
  end
  
  def execute_transaction
    if self.valid? && self.status = "pending"
      sender.balance -= self.amount
      receiver.balance += self.amount
      self.status = "complete"
      self.class.completed << self
    elsif !self.valid?
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    else
      "Transaction complete."
    end
  end
  
  def reverse_transfer
    if self.class.completed.include?(self)
      sender.balance += self.amount
      receiver.balance -= self.amount
      self.status = "reversed"
    else
      "Transaction pending."
    end
  end
end
