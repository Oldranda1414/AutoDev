sourceStrings = {
      "Calculator-background.feature": "features",
      "Calculator-outline.feature": "features",
      "Calculator.feature": "features"
    };

calculatorDirs = [src-dir test-src-dir];

mainConfigs = {
  project: {
    name: "calculator",
    version: "0.1.0",
    description: "A simple command line calculator program.",
    dependencies: ["scala"],
  },

  src: {
    dirs: calculatorDirs,
  },
  test: {
    dirs: [src-dir test-src-dir],
    tests: [
      CalculatorSteps.java,
      CalculatorTest.java,
      CalculatorTest_CalculatorSteps.java,
    ],
  }
};