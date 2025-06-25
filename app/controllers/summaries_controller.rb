class SummariesController < ApplicationController
  def get_summary
    authorize Summary
    summary = policy_scope(Summary).find_by(month: Date.current.month, year: Date.current.year)
    render json: Summaries::GetSummarySerializer.new(summary).as_json, status: :ok
  end
end


# # app/controllers/summaries_controller.rb
# class SummariesController < ApplicationController
#   def get_summary
#     authorize Summary
#
#     # Filtra por mês e ano, se fornecidos
#     month = params[:month]&.to_i
#     year = params[:year]&.to_i
#
#     if month && year
#       # Busca um único Summary para o mês/ano especificado
#       summary = policy_scope(Summary).find_by(month: month, year: year)
#       if summary
#         render json: Summaries::GetSummarySerializer.new(summary), status: :ok
#       else
#         render json: { errors: "Summary not found for month #{month} and year #{year}" }, status: :not_found
#       end
#     else
#       # Retorna todos os Summaries do usuário
#       summaries = policy_scope(Summary)
#       render json: summaries, each_serializer: Summaries::GetSummarySerializer, status: :ok
#     end
#   end
# end
