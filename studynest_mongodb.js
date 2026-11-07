// StudyNest feedback (MongoDB): database StudyNest, collection studynest_feedback
const sdb = db.getSiblingDB("StudyNest");

const validator = {
  $jsonSchema: {
    bsonType: "object",
    required: ["userId", "message", "submittedAt"],
    properties: {
      userId:      { bsonType: "number", description: "user id from user-service" },
      message:     { bsonType: "string", minLength: 1, maxLength: 1000 },
      submittedAt: { bsonType: "date" }
    }
  }
};

if (sdb.getCollectionNames().includes("studynest_feedback")) {
  sdb.runCommand({ collMod: "studynest_feedback", validator: validator });
} else {
  sdb.createCollection("studynest_feedback", { validator: validator });
}

sdb.studynest_feedback.createIndex({ userId: 1 });
sdb.studynest_feedback.createIndex({ submittedAt: -1 });

// optional sample document (delete these lines if you don't want it)
sdb.studynest_feedback.insertOne({
  userId: 1,
  message: "Great app!",
  submittedAt: new Date()
});