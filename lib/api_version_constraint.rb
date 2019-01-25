class ApiVersionConstraint
	def initialize(options)
		@version = options[:version]
	end

	def matches?(req)
		@default || req.headers['Accept'].include?("application/vnd.teste-two.v#{@version}")
	end
end