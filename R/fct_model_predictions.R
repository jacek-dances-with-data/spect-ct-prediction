#' model_predictions
#'
#' @importFrom iBreakDown break_down
#' @importFrom DALEX predict_parts
#' @importFrom DALEX predict_profile
#' @import workflows
#' @import recipes
#' @import ggplot2
#' @import glmnet
#' @import tidyr

model <- readRDS("./R/artifacts/model")
explainer <- readRDS("./R/artifacts/explainer")


#' Calculates positive SPECT-CT result probability from model
#'
#' @param model a fitted model
#' @param newdata a data frame for which to calculate predictions
#' @return a dataframe with predicted probability converted to % in 0-100 range and predicted result (Positive/Negative)
#'
#' @author Jacek Podlewski
prediction_probs <- function(model, newdata){
  probs <- (predict(model, newdata, type="prob")*100)[1,]

  if (probs[1,".pred_0"] >  probs[1,".pred_1"] ){
    probs["Predicted result"] <- "Negative"
    probs <- probs[,c("Predicted result",".pred_0")]
  } else
  {
    probs["Predicted result"] <- "Positive"
    probs <- probs[,c("Predicted result",".pred_1")]
  }

  colnames(probs) <- c("Predicted result","Probability [%]")

  return(probs)
}


pfun <- function(object, newdata) {
  as.vector(predict(object, new_data=newdata, type="class"))[[1]]
}

pfun_num <- function(object, newdata) {
  as.numeric(pfun(object, newdata))-1
}

pfun_prob <- function(object, newdata) {
  as.vector(predict(object, new_data=newdata, type="prob"))[[2]]
}

#' Creates a breakdown plot for prediction using Sequential Variable Attributions Conditioning
#'
#' @param model a fitted model
#' @param explainer a DALEX explainer object for the model
#' @param newdata a data frame for which to calculate predictions
#' @param order Order of variables, passed to iBreakDown::break_down function
#'
#' @return a breakdown plot for the calculated prediction
#'
#' @author Jacek Podlewski
plot_prediction_explanation <- function(model, explainer, newdata, order=NULL, ...){
  pred_prob <- predict(model, new_data=newdata, type="prob")$.pred_1
  plot(break_down(explainer, newdata, order=order),
       title = "Prediction Explanation",
       subtitle = paste0("Probability of positive scintigraphy: ", round(100*pred_prob,2), "%"), ...) +
    theme_bw() +
    guides(fill="none")
}

#' Creates a SHAP plot for prediciton
#'
#' @param model a fitted model
#' @param explainer a DALEX explainer object for the model
#' @param newdata a data frame for which to calculate predictions
#' @param max_features maximal number of features to show on plot
#'
#' @return a SHAP plot for the calculated prediction
#'
#' @author Jacek Podlewski
plot_shap <- function(model, explainer, new_data, max_features=5, ...){
  pred_prob <- predict(model, new_data=new_data, type="prob")$.pred_1
  set.seed(1)
  plot(predict_parts(explainer = explainer,
                     new_observation = new_data,
                     type = "shap",
                     ...),
       max_features=max_features) +
    theme_bw() +
    guides(fill="none") +
    ggtitle(paste0("Probability of positive scintigraphy: ", round(100*pred_prob,2)))
}

#' Creates a Ceteris Paribus profile plot for prediciton
#'
#' @param model a fitted model
#' @param explainer a DALEX explainer object for the model
#' @param newdata a data frame for which to calculate predictions
#' @param grid type of point grid to use on the graph, 'quantiles' or 'uniform'
#'
#' @return a Ceteris Paribus profile plot for the calculated prediction
#'
#' @author Jacek Podlewski
plot_prediction_profile <- function(model, explainer, new_data, grid="quantile", ...){
  pred_prob <- predict(model, new_data=new_data[1,], type="prob")$.pred_1
  plot(predict_profile(explainer = explainer,
                       new_observation = new_data[1,],
                       variable_splits_type=grid),  facet_ncol=5) +
    theme_bw() +
    ggtitle(paste0("Prediction profile. Probability of positive scintigraphy: ", round(pred_prob*100,2),"%"),
            subtitle=paste0(explainer$label, " model"))
}
