sample_data <- data.frame("PTH"=c(1, 10, 100, 200, 500),
                        "Ca"=c(1, 1.5, 2, 3, 4),
                        "max_diameter"=c(0,0,NA,0.8, 1.),
                        "vit_D"=c(10, 20, 30, 40, 50),
                        "Pi"=c(1, 1, 0.5, 1, 1.5))

model <- readRDS("../../R/artifacts/model")
explainer <- readRDS("../../R/artifacts/explainer")


test_that(
  "correct columns are returned",
  {
    predictions <- prediction_probs(model, sample_data[1,])
    expected_columns <- c("Predicted result","Probability [%]")
    expect_equal(colnames(predictions), expected_columns)
  }
)

test_that(
  "valid classes are returned",
  {
    predictions <- numeric(5)
    for (i in 1:5){
      predictions[i] <- prediction_probs(model, sample_data[i,])[1, 1]
    }
    unique_results <- sort(unique(predictions))
    expected_results <- c("Negative","Positive")
    expect_equal(unique_results, expected_results)
  }
)

test_that(
  "valid probabilities are returned",
  {
   predictions <- numeric(5)
   for (i in 1:5){
      predictions[i] <- prediction_probs(model, sample_data[i,])[1, 2]
   }
   expect_true(max(predictions)<=100)
   expect_true(min(predictions)>=0)
  }
)

test_that(
  "SHAP graph is created correctly",
  {
    g <- plot_shap(model, explainer, sample_data[1,])
    expect_true(is_ggplot(g))
    expect_true(grep("Probability of positive scintigraphy", g$labels$title)==1)
  }
)

test_that(
  "Breakdown graph is created correctly",
  {
    g <- plot_prediction_explanation(model, explainer, sample_data[1,])
    expect_true(is_ggplot(g))
    expect_equal( g$labels$title, "Prediction Explanation")
    expect_true(grep("Probability of positive scintigraphy", g$labels$subtitle)==1)
  }
)

test_that(
  "Ceteris Paribus profile graph is created correctly",
  {
    g <- plot_prediction_profile(model, explainer, sample_data[1,])
    expect_true(is_ggplot(g))
    expect_equal( g$labels$subtitle, "Logistic Regression model")
    expect_true(grep("Probability of positive scintigraphy", g$labels$title)==1)
  }
)

