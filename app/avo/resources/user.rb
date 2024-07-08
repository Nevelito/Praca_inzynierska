# frozen_string_literal: true

module Avo
  module Resources
    class User < Avo::BaseResource
      self.includes = []
      # self.search = {
      #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
      # }

      def fields
        field :id, as: :idlo
        field :email, as: :text
      end
    end
  end
end
