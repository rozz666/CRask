module CRask
  class GeneratorConfiguration
    def object_type
      "CRASK_OBJECT"
    end
    def class_type
      "CRASK_CLASS"
    end
    def nil_var
      "CRASK_NIL"
    end
    def self_var
      "self"
    end
    def class_self_var
      "classSelf"
    end
    def va_list
      "rask_args"
    end
  end
end