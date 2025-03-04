export const createLocalization = async (key, languageCode, textContent, component) => {
    logger.database("METHOD api/admin/localization - CREATE");
    try {
      const query = `
        INSERT INTO public.localization00 (key, language_code, textcontent, component)
        VALUES ($1, $2, $3, $4)
        RETURNING *;
      `;
      const values = [key, languageCode, textContent, component];
      const result = await db.query(query, values);
      return result.rows[0];
    } catch (err) {
      logger.error(err.message);
      throw err;
    }
  };
  export const fetchLocalizations = async (filters = {}) => {
    logger.database("METHOD api/admin/localization - READ");
    try {
      let query = `SELECT * FROM public.localization00`;
      const values = [];
      const conditions = [];
  
      // Add filters if provided
      if (filters.key) {
        conditions.push(`key = $${values.length + 1}`);
        values.push(filters.key);
      }
      if (filters.languageCode) {
        conditions.push(`language_code = $${values.length + 1}`);
        values.push(filters.languageCode);
      }
      if (filters.component) {
        conditions.push(`component = $${values.length + 1}`);
        values.push(filters.component);
      }
  
      if (conditions.length > 0) {
        query += ` WHERE ${conditions.join(' AND ')}`;
      }
  
      const result = await db.query(query, values);
      return result.rows;
    } catch (err) {
      logger.error(err.message);
      throw err;
    }
  };
  export const updateLocalization = async (id, key, languageCode, textContent, component) => {
    logger.database("METHOD api/admin/localization - UPDATE");
    try {
      const query = `
        UPDATE public.localization00
        SET key = $1, language_code = $2, textcontent = $3, component = $4
        WHERE id = $5
        RETURNING *;
      `;
      const values = [key, languageCode, textContent, component, id];
      const result = await db.query(query, values);
      return result.rows[0];
    } catch (err) {
      logger.error(err.message);
      throw err;
    }
  };
  export const deleteLocalization = async (id) => {
    logger.database("METHOD api/admin/localization - DELETE");
    try {
      const query = `
        DELETE FROM public.localization00
        WHERE id = $1
        RETURNING *;
      `;
      const values = [id];
      const result = await db.query(query, values);
      return result.rows[0];
    } catch (err) {
      logger.error(err.message);
      throw err;
    }
  };
  export const createEstablishment = async (
    estName, type, cityMun, barangay, latitude, longitude,
    english, korean, chinese, japanese, russian, french, spanish, hindi
  ) => {
    logger.database("METHOD api/admin/establishments - CREATE");
    try {
      const query = `
        INSERT INTO public.establishments (
          est_name, type, city_mun, barangay, latitude, longitude,
          english, korean, chinese, japanese, russian, french, spanish, hindi
        )
        VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14)
        RETURNING *;
      `;
      const values = [
        estName, type, cityMun, barangay, latitude, longitude,
        english, korean, chinese, japanese, russian, french, spanish, hindi
      ];
      const result = await db.query(query, values);
      return result.rows[0];
    } catch (err) {
      logger.error(err.message);
      throw err;
    }
  };
  export const fetchEstablishments = async (filters = {}) => {
    logger.database("METHOD api/admin/establishments - READ");
    try {
      let query = `SELECT * FROM public.establishments`;
      const values = [];
      const conditions = [];
  
      // Add filters if provided
      if (filters.estName) {
        conditions.push(`est_name ILIKE $${values.length + 1}`);
        values.push(`%${filters.estName}%`);
      }
      if (filters.type) {
        conditions.push(`type = $${values.length + 1}`);
        values.push(filters.type);
      }
      if (filters.cityMun) {
        conditions.push(`city_mun = $${values.length + 1}`);
        values.push(filters.cityMun);
      }
      if (filters.barangay) {
        conditions.push(`barangay = $${values.length + 1}`);
        values.push(filters.barangay);
      }
  
      if (conditions.length > 0) {
        query += ` WHERE ${conditions.join(' AND ')}`;
      }
  
      const result = await db.query(query, values);
      return result.rows;
    } catch (err) {
      logger.error(err.message);
      throw err;
    }
  };
  export const updateEstablishment = async (
    id, estName, type, cityMun, barangay, latitude, longitude,
    english, korean, chinese, japanese, russian, french, spanish, hindi
  ) => {
    logger.database("METHOD api/admin/establishments - UPDATE");
    try {
      const query = `
        UPDATE public.establishments
        SET
          est_name = $1, type = $2, city_mun = $3, barangay = $4, latitude = $5, longitude = $6,
          english = $7, korean = $8, chinese = $9, japanese = $10, russian = $11, french = $12, spanish = $13, hindi = $14
        WHERE id = $15
        RETURNING *;
      `;
      const values = [
        estName, type, cityMun, barangay, latitude, longitude,
        english, korean, chinese, japanese, russian, french, spanish, hindi, id
      ];
      const result = await db.query(query, values);
      return result.rows[0];
    } catch (err) {
      logger.error(err.message);
      throw err;
    }
  };
  export const deleteEstablishment = async (id) => {
    logger.database("METHOD api/admin/establishments - DELETE");
    try {
      const query = `
        DELETE FROM public.establishments
        WHERE id = $1
        RETURNING *;
      `;
      const values = [id];
      const result = await db.query(query, values);
      return result.rows[0];
    } catch (err) {
      logger.error(err.message);
      throw err;
    }
  };
  export const createTourismAttraction = async (
    taName, typeCode, region, provHuc, cityMun, reportYear, brgy,
    latitude, longitude, taCategory, ntdpCategory, devtLvl, mgt, onlineConnectivity
  ) => {
    logger.database("METHOD api/admin/tourismattractions - CREATE");
    try {
      const query = `
        INSERT INTO public.tourismattractions (
          ta_name, type_code, region, prov_huc, city_mun, report_year, brgy,
          latitude, longitude, ta_category, ntdp_category, devt_lvl, mgt, online_connectivity
        )
        VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14)
        RETURNING *;
      `;
      const values = [
        taName, typeCode, region, provHuc, cityMun, reportYear, brgy,
        latitude, longitude, taCategory, ntdpCategory, devtLvl, mgt, onlineConnectivity
      ];
      const result = await db.query(query, values);
      return result.rows[0];
    } catch (err) {
      logger.error(err.message);
      throw err;
    }
  };
  export const fetchTourismAttractions = async (filters = {}) => {
    logger.database("METHOD api/admin/tourismattractions - READ");
    try {
      let query = `SELECT * FROM public.tourismattractions`;
      const values = [];
      const conditions = [];
  
      // Add filters if provided
      if (filters.taName) {
        conditions.push(`ta_name ILIKE $${values.length + 1}`);
        values.push(`%${filters.taName}%`);
      }
      if (filters.typeCode) {
        conditions.push(`type_code = $${values.length + 1}`);
        values.push(filters.typeCode);
      }
      if (filters.region) {
        conditions.push(`region = $${values.length + 1}`);
        values.push(filters.region);
      }
      if (filters.cityMun) {
        conditions.push(`city_mun = $${values.length + 1}`);
        values.push(filters.cityMun);
      }
      if (filters.reportYear) {
        conditions.push(`report_year = $${values.length + 1}`);
        values.push(filters.reportYear);
      }
      if (filters.taCategory) {
        conditions.push(`ta_category = $${values.length + 1}`);
        values.push(filters.taCategory);
      }
  
      if (conditions.length > 0) {
        query += ` WHERE ${conditions.join(' AND ')}`;
      }
  
      const result = await db.query(query, values);
      return result.rows;
    } catch (err) {
      logger.error(err.message);
      throw err;
    }
  };
  export const updateTourismAttraction = async (
    id, taName, typeCode, region, provHuc, cityMun, reportYear, brgy,
    latitude, longitude, taCategory, ntdpCategory, devtLvl, mgt, onlineConnectivity
  ) => {
    logger.database("METHOD api/admin/tourismattractions - UPDATE");
    try {
      const query = `
        UPDATE public.tourismattractions
        SET
          ta_name = $1, type_code = $2, region = $3, prov_huc = $4, city_mun = $5, report_year = $6, brgy = $7,
          latitude = $8, longitude = $9, ta_category = $10, ntdp_category = $11, devt_lvl = $12, mgt = $13, online_connectivity = $14
        WHERE id = $15
        RETURNING *;
      `;
      const values = [
        taName, typeCode, region, provHuc, cityMun, reportYear, brgy,
        latitude, longitude, taCategory, ntdpCategory, devtLvl, mgt, onlineConnectivity, id
      ];
      const result = await db.query(query, values);
      return result.rows[0];
    } catch (err) {
      logger.error(err.message);
      throw err;
    }
  };
  export const deleteTourismAttraction = async (id) => {
    logger.database("METHOD api/admin/tourismattractions - DELETE");
    try {
      const query = `
        DELETE FROM public.tourismattractions
        WHERE id = $1
        RETURNING *;
      `;
      const values = [id];
      const result = await db.query(query, values);
      return result.rows[0];
    } catch (err) {
      logger.error(err.message);
      throw err;
    }
  };
  