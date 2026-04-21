import streamlit as st

st.set_page_config(page_title="Campaign Probability Tool")

st.title("📊 Campaign Uncertainty Modeler")

st.write("Model uncertainty, update beliefs, and compare campaign scenarios.")

# --- Input: Hypothesis ---
st.header("1. Define Hypothesis")
hypothesis = st.text_input("What are you testing?", 
                          placeholder="e.g. 'This campaign angle will drive engagement'")

# --- Input: Prior ---
st.header("2. Assign Initial Probability")
prior = st.slider("Initial belief (%)", 1, 99, 50) / 100

# --- Input: Evidence ---
st.header("3. Add Evidence")

evidence = st.text_input("What evidence do you have?", 
                         placeholder="e.g. 'Similar campaigns performed well'")

likelihood = st.slider("How likely is this evidence if the hypothesis is TRUE? (%)", 1, 99, 70) / 100
alt_likelihood = st.slider("How likely is this evidence if the hypothesis is FALSE? (%)", 1, 99, 30) / 100

# --- Bayesian Update ---
def bayesian_update(prior, likelihood, alt_likelihood):
    numerator = likelihood * prior
    denominator = numerator + (alt_likelihood * (1 - prior))
    return numerator / denominator

if st.button("Update Belief"):
    posterior = bayesian_update(prior, likelihood, alt_likelihood)
    
    st.subheader("📈 Updated Probability")
    st.write(f"**{posterior * 100:.2f}%** likelihood your hypothesis is correct")

    st.write("### 🧠 Interpretation")
    if posterior > prior:
        st.success("Your evidence strengthens the hypothesis.")
    else:
        st.warning("Your evidence weakens the hypothesis.")

# --- Scenario Comparison ---
st.header("4. Compare Scenarios")

scenario_1 = st.text_input("Scenario A", placeholder="e.g. Fear-based messaging")
scenario_2 = st.text_input("Scenario B", placeholder="e.g. Data-driven messaging")

prob_1 = st.slider("Probability Scenario A succeeds (%)", 1, 99, 50)
prob_2 = st.slider("Probability Scenario B succeeds (%)", 1, 99, 50)

if st.button("Compare"):
    st.subheader("🏆 Recommendation")
    if prob_1 > prob_2:
        st.success(f"Go with Scenario A: {scenario_1}")
    elif prob_2 > prob_1:
        st.success(f"Go with Scenario B: {scenario_2}")
    else:
        st.info("Both scenarios are equally viable—test both.")

# --- Footer Insight ---
st.markdown("---")
st.caption("Think in probabilities, not certainties.")
