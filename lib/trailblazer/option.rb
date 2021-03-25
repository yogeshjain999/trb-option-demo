module Trailblazer
  class Option
    # A call implementation invoking `value.(*args)` and plainly forwarding all arguments.
    # Override this for your own step strategy (see KW#call!).
    # @private
    def self.call!(value, *args, calling: :call, keyword_arguments: {}, **, &block)
      # {**keyword_arguments} gets removed automatically if it's an empty hash.
      # DISCUSS: is this a good practice?
      value.send(calling, *args, **keyword_arguments, &block)
    end

    # Note that both #evaluate_callable and #evaluate_method drop most of the args.
    # If you need those, override this class.
    #
    # @private
    def self.evaluate_callable(value, *args, **options, &block)
      call!(value, *args, **options, &block)
    end

    # Make the exec_context's instance method a "lambda" and reuse #call!.
    # @private
    def self.evaluate_method(value, *args, exec_context: raise("No :exec_context given."), **options, &block)
      call!(exec_context.method(value), *args, **options, &block)
    end

    # Generic builder for a callable "option".
    # @param call_implementation [Class, Module] implements the process of calling the proc
    #   while passing arguments/options to it in a specific style (e.g. kw args, step interface).
    # @return [Proc] when called, this proc will evaluate its option (at run-time).
    def self.build(value)
      case value
      when Symbol
        ->(*args, **kws, &block) { evaluate_method(value, *args, **kws, &block) }
      when Proc, Class
        ->(*args, **kws, &block) { evaluate_callable(value, *args, **kws, &block) }
      else
        ->(*) { value }
      end
    end
  end

  def self.Option(value)
    Option.build(value)
  end
end
