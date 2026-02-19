# functions.R
# this script loads all the functions that run.R needs

extract_key_param_draws <- function(fit, model_id) {
  d <- posterior::as_draws_df(fit)
  tibble::tibble(
    model_id = model_id,
    b_logOR  = d[["b_treatmentthrombectomy"]],
    sd_int   = d[["sd_trial__Intercept"]],
    sd_trt   = d[["sd_trial__treatmentthrombectomy"]],
    cor_int_trt = d[["cor_trial__Intercept__treatmentthrombectomy"]]
  )
}

get_trials_var <- function(fit) {
  ftxt <- paste(deparse(formula(fit)), collapse = " ")
  m <- regexec("trials\\(([^)]+)\\)", ftxt)
  hit <- regmatches(ftxt, m)[[1]]
  if (length(hit) >= 2) trimws(hit[2]) else NULL
}

extract_trial_pgood_draws <- function(fit, model_id,
                                      good_levels = c("0","1","2"),
                                      resp = "mrs_better") {
  
  nd <- tidyr::expand_grid(
    trial = levels(fit$data$trial),
    treatment = levels(fit$data$treatment)
  )
  
  fam <- family(fit)$family
  
  if (fam %in% c("bernoulli", "binomial")) {
    trials_var <- get_trials_var(fit)
    if (!is.null(trials_var)) nd[[trials_var]] <- 1
    
    p <- brms::posterior_epred(fit, newdata = nd, re_formula = NULL) # draws x rows
  } else {
    probs <- brms::posterior_epred(fit, newdata = nd, re_formula = NULL) # draws x rows x K
    lev <- dimnames(probs)[[3]] %||% levels(fit$data[[resp]])
    good_idx <- which(lev %in% good_levels)
    if (!length(good_idx)) stop(model_id, ": good_levels not found in ", resp)
    
    p <- apply(probs[,,good_idx, drop = FALSE], c(1,2), sum) # draws x rows
  }
  
  # long format: one row per draw per (trial,treatment)
  S <- nrow(p)
  tibble(
    model_id = model_id,
    draw = rep(seq_len(S), times = nrow(nd)),
    trial = rep(nd$trial, each = S),
    treatment = rep(nd$treatment, each = S),
    p_good = as.vector(p)
  )
}

