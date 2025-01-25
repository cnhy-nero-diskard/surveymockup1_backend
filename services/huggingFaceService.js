import logger from "../middleware/logger.js";
// services/huggingFaceService.js
export const queryHuggingFace = async (data, apiToken) => {
    logger.info("Querying Hugging Face model");
    logger.info(`Data:, ${data}`);
    logger.info(`API Token: ${apiToken}`);
    const response = await fetch(
      "https://api-inference.huggingface.co/models/lxyuan/distilbert-base-multilingual-cased-sentiments-student",
      {
        headers: {
          Authorization: `Bearer ${apiToken}`,
          "Content-Type": "application/json",
        },
        method: "POST",
        body: JSON.stringify(data),
      }
    );
    const result = await response.json();
    logger.info(`Hugging Face response: ${result}`);
    return result;
  };