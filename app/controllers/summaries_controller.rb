class SummariesController < ApplicationController
  def get_summary
    authorize Summary
    schema = Summaries::GetSummarySchema.new
    data = schema.call(params.to_unsafe_h)
    if data.success?
      month = data[:month]&.to_i
      year = data[:year]&.to_i
      if month && year
        summary = policy_scope(Summary).find_by(month: month, year: year)
        if summary
          render json: Summaries::GetSummarySerializer.new(summary), status: :ok
        else
          render json: { errors: "Summary not found for month #{month} and year #{year}" }, status: :not_found
        end
      else
        summaries = policy_scope(Summary)
        render json: summaries, each_serializer: Summaries::GetSummarySerializer, status: :ok
      end
    else
      render json: { errors: data.errors.to_h }, status: :unprocessable_entity
    end
  end
end
