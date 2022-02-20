import Cocoa
import CreateML

let data = try MLDataTable(contentsOf: URL(fileURLWithPath: "/Users/ranyou/Downloads/twitter-sanders-apple.csv"))

let (trainingData,testingData) = data.randomSplit(by: 0.8, seed: 5)

let sentimentClassifer = try MLTextClassifier(trainingData: trainingData, textColumn: "text", labelColumn: "class")

let evaluationMetrics = sentimentClassifer.evaluation(on: testingData, textColumn: "text", labelColumn: "class")

let evaluationAccuracy = (1.0 - evaluationMetrics.classificationError) * 100

let metadata = MLModelMetadata(author: "Ran You", shortDescription: "Sentiment Analysis", version: "v1")

try sentimentClassifer.write(to: URL(fileURLWithPath:"/Users/ranyou/Downloads/TweetSentiment.mlmodel"))

try sentimentClassifer.prediction(from: "Rosie is great")

try sentimentClassifer.prediction(from: "Amazon is a bad company")
