class Hash
  # Recursively merges 2 hashes. By default Ruby has a shallow merge.
  #  {:a => {:a => 1, :b => 1}}.recursive_merge({:a => {:b => 2}})
  #  => {:a => {:a => 1, :b => 2}}
  def recursive_merge(other)
    hash = self.dup
    other.each do |key, value|
      myval = self[key]
      if value.is_a?(Hash) && myval.is_a?(Hash)
        hash[key] = myval.recursive_merge(value)
      else
        hash[key] = value
      end
    end
    hash
  end
end