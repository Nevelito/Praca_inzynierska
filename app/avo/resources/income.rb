# frozen_string_literal: true

module Avo
  module Resources
    class Income < Avo::BaseResource
      self.includes = []
      # self.search = {
      #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
      # }

      def fields
        field :id, as: :id
      end
    end
  end
end
