'use strict'

const AWS = require('aws-sdk')
AWS.config.update({ region: process.env.AWS_REGION })
const s3 = new AWS.S3()
const uploadBucket = "imagebucketserverless"

// Change this value to adjust the signed URL's expiration
const URL_EXPIRATION_SECONDS = 300

// Main Lambda entry point
exports.handler = async (event) => {
  return await getUploadURL(event)
}

const getUploadURL = async function(event) {
  const randomID = parseInt(Math.random() * 10000000)
  const Key = `${randomID}.jpg`

  // Get signed URL from S3
  const s3Params = {
    Bucket: uploadBucket,
    Key,
    Expires: URL_EXPIRATION_SECONDS,
    ContentType: 'image/jpeg',

  }

  console.log('Params: ', s3Params)
  const uploadURL = await s3.getSignedUrlPromise('putObject', s3Params)

  return JSON.stringify({
    uploadURL: uploadURL,
    Key
  })
}