class ThanksTo
  def self.thanks_to(node, site)
    node_name = node['name'].split('.')[0]
    roles = node['automatic']['roles'] || []
    thanks_override = site.data['thanks']

    if roles.include? "ic"
      "Imperial College London"
    elsif roles.include? "ucl"
      "University College London"
    elsif roles.include? "bytemark"
      "Bytemark"
    elsif thanks_override.has_key? node_name
      thanks_override[node_name]
    else
      node['default']['hosted_by']
    end
  end
end

module Jekyll
  module ThanksToFilter
    def thanks_to(node)
      if node.is_a? Array
        return node.map {|n| thanks_to(n)}
      end

      ThanksTo::thanks_to(node, @context.registers[:site])
    end
  end
end

Liquid::Template.register_filter(Jekyll::ThanksToFilter)
