import logger from "../middleware/logger.js";

export const queryHuggingFace = async (data, apiToken) => {
    logger.info("Querying Hugging Face model");
    logger.info(`Data: ${JSON.stringify(data)}`);
    logger.info(`API Token: ${apiToken}`);

    const modelUrl = "https://api-inference.huggingface.co/models/lxyuan/distilbert-base-multilingual-cased-sentiments-student";

    const queryModel = async () => {
        const response = await fetch(modelUrl, {
            headers: {
                Authorization: `Bearer ${apiToken}`,
                "Content-Type": "application/json",
            },
            method: "POST",
            body: JSON.stringify(data),
        });

        const result = await response.json();
        logger.info(`Hugging Face response: ${JSON.stringify(result)}`);

        if (result.error && result.error.includes("is currently loading")) {
            // If the model is still loading, wait for the estimated time and retry
            const estimatedTime = result.estimated_time;
            logger.info(`Model is loading. Retrying in ${estimatedTime} seconds...`);
            await new Promise((resolve) => setTimeout(resolve, estimatedTime * 1000));
            return queryModel(); // Retry the request
        }

        return result;
    };

    try {
        const result = await queryModel();
        return result;
    } catch (error) {
        logger.error(`Error querying Hugging Face model: ${error.message}`);
        throw error;
    }
};