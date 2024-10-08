//
// This file is auto-generated. Please don't modify it!
//
#pragma once

#ifdef __cplusplus
//#import "opencv.hpp"
#import "opencv2/imgcodecs.hpp"
#else
#define CV_EXPORTS
#endif

#import <Foundation/Foundation.h>

@class ByteVector;
@class IntVector;
@class Mat;
@class Range;


// C++: enum ImreadModes (cv.ImreadModes)
typedef NS_ENUM(int, ImreadModes) {
    IMREAD_UNCHANGED = -1,
    IMREAD_GRAYSCALE = 0,
    IMREAD_COLOR_BGR = 1,
    IMREAD_COLOR = 1,
    IMREAD_ANYDEPTH = 2,
    IMREAD_ANYCOLOR = 4,
    IMREAD_LOAD_GDAL = 8,
    IMREAD_REDUCED_GRAYSCALE_2 = 16,
    IMREAD_REDUCED_COLOR_2 = 17,
    IMREAD_REDUCED_GRAYSCALE_4 = 32,
    IMREAD_REDUCED_COLOR_4 = 33,
    IMREAD_REDUCED_GRAYSCALE_8 = 64,
    IMREAD_REDUCED_COLOR_8 = 65,
    IMREAD_IGNORE_ORIENTATION = 128,
    IMREAD_COLOR_RGB = 256
};


// C++: enum ImwriteEXRCompressionFlags (cv.ImwriteEXRCompressionFlags)
typedef NS_ENUM(int, ImwriteEXRCompressionFlags) {
    IMWRITE_EXR_COMPRESSION_NO = 0,
    IMWRITE_EXR_COMPRESSION_RLE = 1,
    IMWRITE_EXR_COMPRESSION_ZIPS = 2,
    IMWRITE_EXR_COMPRESSION_ZIP = 3,
    IMWRITE_EXR_COMPRESSION_PIZ = 4,
    IMWRITE_EXR_COMPRESSION_PXR24 = 5,
    IMWRITE_EXR_COMPRESSION_B44 = 6,
    IMWRITE_EXR_COMPRESSION_B44A = 7,
    IMWRITE_EXR_COMPRESSION_DWAA = 8,
    IMWRITE_EXR_COMPRESSION_DWAB = 9
};


// C++: enum ImwriteEXRTypeFlags (cv.ImwriteEXRTypeFlags)
typedef NS_ENUM(int, ImwriteEXRTypeFlags) {
    IMWRITE_EXR_TYPE_HALF = 1,
    IMWRITE_EXR_TYPE_FLOAT = 2
};


// C++: enum ImwriteFlags (cv.ImwriteFlags)
typedef NS_ENUM(int, ImwriteFlags) {
    IMWRITE_JPEG_QUALITY = 1,
    IMWRITE_JPEG_PROGRESSIVE = 2,
    IMWRITE_JPEG_OPTIMIZE = 3,
    IMWRITE_JPEG_RST_INTERVAL = 4,
    IMWRITE_JPEG_LUMA_QUALITY = 5,
    IMWRITE_JPEG_CHROMA_QUALITY = 6,
    IMWRITE_JPEG_SAMPLING_FACTOR = 7,
    IMWRITE_PNG_COMPRESSION = 16,
    IMWRITE_PNG_STRATEGY = 17,
    IMWRITE_PNG_BILEVEL = 18,
    IMWRITE_PXM_BINARY = 32,
    IMWRITE_EXR_TYPE = (3 << 4) + 0,
    IMWRITE_EXR_COMPRESSION = (3 << 4) + 1,
    IMWRITE_EXR_DWA_COMPRESSION_LEVEL = (3 << 4) + 2,
    IMWRITE_WEBP_QUALITY = 64,
    IMWRITE_HDR_COMPRESSION = (5 << 4) + 0,
    IMWRITE_PAM_TUPLETYPE = 128,
    IMWRITE_TIFF_RESUNIT = 256,
    IMWRITE_TIFF_XDPI = 257,
    IMWRITE_TIFF_YDPI = 258,
    IMWRITE_TIFF_COMPRESSION = 259,
    IMWRITE_TIFF_ROWSPERSTRIP = 278,
    IMWRITE_TIFF_PREDICTOR = 317,
    IMWRITE_JPEG2000_COMPRESSION_X1000 = 272,
    IMWRITE_AVIF_QUALITY = 512,
    IMWRITE_AVIF_DEPTH = 513,
    IMWRITE_AVIF_SPEED = 514
};


// C++: enum ImwriteHDRCompressionFlags (cv.ImwriteHDRCompressionFlags)
typedef NS_ENUM(int, ImwriteHDRCompressionFlags) {
    IMWRITE_HDR_COMPRESSION_NONE = 0,
    IMWRITE_HDR_COMPRESSION_RLE = 1
};


// C++: enum ImwriteJPEGSamplingFactorParams (cv.ImwriteJPEGSamplingFactorParams)
typedef NS_ENUM(int, ImwriteJPEGSamplingFactorParams) {
    IMWRITE_JPEG_SAMPLING_FACTOR_411 = 0x411111,
    IMWRITE_JPEG_SAMPLING_FACTOR_420 = 0x221111,
    IMWRITE_JPEG_SAMPLING_FACTOR_422 = 0x211111,
    IMWRITE_JPEG_SAMPLING_FACTOR_440 = 0x121111,
    IMWRITE_JPEG_SAMPLING_FACTOR_444 = 0x111111
};


// C++: enum ImwritePAMFlags (cv.ImwritePAMFlags)
typedef NS_ENUM(int, ImwritePAMFlags) {
    IMWRITE_PAM_FORMAT_NULL = 0,
    IMWRITE_PAM_FORMAT_BLACKANDWHITE = 1,
    IMWRITE_PAM_FORMAT_GRAYSCALE = 2,
    IMWRITE_PAM_FORMAT_GRAYSCALE_ALPHA = 3,
    IMWRITE_PAM_FORMAT_RGB = 4,
    IMWRITE_PAM_FORMAT_RGB_ALPHA = 5
};


// C++: enum ImwritePNGFlags (cv.ImwritePNGFlags)
typedef NS_ENUM(int, ImwritePNGFlags) {
    IMWRITE_PNG_STRATEGY_DEFAULT = 0,
    IMWRITE_PNG_STRATEGY_FILTERED = 1,
    IMWRITE_PNG_STRATEGY_HUFFMAN_ONLY = 2,
    IMWRITE_PNG_STRATEGY_RLE = 3,
    IMWRITE_PNG_STRATEGY_FIXED = 4
};


// C++: enum ImwriteTiffCompressionFlags (cv.ImwriteTiffCompressionFlags)
typedef NS_ENUM(int, ImwriteTiffCompressionFlags) {
    IMWRITE_TIFF_COMPRESSION_NONE = 1,
    IMWRITE_TIFF_COMPRESSION_CCITTRLE = 2,
    IMWRITE_TIFF_COMPRESSION_CCITTFAX3 = 3,
    IMWRITE_TIFF_COMPRESSION_CCITT_T4 = 3,
    IMWRITE_TIFF_COMPRESSION_CCITTFAX4 = 4,
    IMWRITE_TIFF_COMPRESSION_CCITT_T6 = 4,
    IMWRITE_TIFF_COMPRESSION_LZW = 5,
    IMWRITE_TIFF_COMPRESSION_OJPEG = 6,
    IMWRITE_TIFF_COMPRESSION_JPEG = 7,
    IMWRITE_TIFF_COMPRESSION_T85 = 9,
    IMWRITE_TIFF_COMPRESSION_T43 = 10,
    IMWRITE_TIFF_COMPRESSION_NEXT = 32766,
    IMWRITE_TIFF_COMPRESSION_CCITTRLEW = 32771,
    IMWRITE_TIFF_COMPRESSION_PACKBITS = 32773,
    IMWRITE_TIFF_COMPRESSION_THUNDERSCAN = 32809,
    IMWRITE_TIFF_COMPRESSION_IT8CTPAD = 32895,
    IMWRITE_TIFF_COMPRESSION_IT8LW = 32896,
    IMWRITE_TIFF_COMPRESSION_IT8MP = 32897,
    IMWRITE_TIFF_COMPRESSION_IT8BL = 32898,
    IMWRITE_TIFF_COMPRESSION_PIXARFILM = 32908,
    IMWRITE_TIFF_COMPRESSION_PIXARLOG = 32909,
    IMWRITE_TIFF_COMPRESSION_DEFLATE = 32946,
    IMWRITE_TIFF_COMPRESSION_ADOBE_DEFLATE = 8,
    IMWRITE_TIFF_COMPRESSION_DCS = 32947,
    IMWRITE_TIFF_COMPRESSION_JBIG = 34661,
    IMWRITE_TIFF_COMPRESSION_SGILOG = 34676,
    IMWRITE_TIFF_COMPRESSION_SGILOG24 = 34677,
    IMWRITE_TIFF_COMPRESSION_JP2000 = 34712,
    IMWRITE_TIFF_COMPRESSION_LERC = 34887,
    IMWRITE_TIFF_COMPRESSION_LZMA = 34925,
    IMWRITE_TIFF_COMPRESSION_ZSTD = 50000,
    IMWRITE_TIFF_COMPRESSION_WEBP = 50001,
    IMWRITE_TIFF_COMPRESSION_JXL = 50002
};


// C++: enum ImwriteTiffPredictorFlags (cv.ImwriteTiffPredictorFlags)
typedef NS_ENUM(int, ImwriteTiffPredictorFlags) {
    IMWRITE_TIFF_PREDICTOR_NONE = 1,
    IMWRITE_TIFF_PREDICTOR_HORIZONTAL = 2,
    IMWRITE_TIFF_PREDICTOR_FLOATINGPOINT = 3
};



NS_ASSUME_NONNULL_BEGIN

// C++: class Imgcodecs
/**
 * The Imgcodecs module
 *
 * Member of `Imgcodecs`
 * Member enums: `ImreadModes`, `ImwriteFlags`, `ImwriteJPEGSamplingFactorParams`, `ImwriteTiffCompressionFlags`, `ImwriteTiffPredictorFlags`, `ImwriteEXRTypeFlags`, `ImwriteEXRCompressionFlags`, `ImwritePNGFlags`, `ImwritePAMFlags`, `ImwriteHDRCompressionFlags`
 */
CV_EXPORTS @interface Imgcodecs : NSObject

#pragma mark - Methods


//
//  Mat cv::imread(String filename, int flags = IMREAD_COLOR_BGR)
//
/**
 * Loads an image from a file.
 *
 *  imread
 *
 * The function imread loads an image from the specified file and returns it. If the image cannot be
 * read (because of missing file, improper permissions, unsupported or invalid format), the function
 * returns an empty matrix ( Mat::data==NULL ).
 *
 * Currently, the following file formats are supported:
 *
 * -   Windows bitmaps - \*.bmp, \*.dib (always supported)
 * -   JPEG files - \*.jpeg, \*.jpg, \*.jpe (see the *Note* section)
 * -   JPEG 2000 files - \*.jp2 (see the *Note* section)
 * -   Portable Network Graphics - \*.png (see the *Note* section)
 * -   WebP - \*.webp (see the *Note* section)
 * -   AVIF - \*.avif (see the *Note* section)
 * -   Portable image format - \*.pbm, \*.pgm, \*.ppm \*.pxm, \*.pnm (always supported)
 * -   PFM files - \*.pfm (see the *Note* section)
 * -   Sun rasters - \*.sr, \*.ras (always supported)
 * -   TIFF files - \*.tiff, \*.tif (see the *Note* section)
 * -   OpenEXR Image files - \*.exr (see the *Note* section)
 * -   Radiance HDR - \*.hdr, \*.pic (always supported)
 * -   Raster and Vector geospatial data supported by GDAL (see the *Note* section)
 *
 * NOTE:
 * -   The function determines the type of an image by the content, not by the file extension.
 * -   In the case of color images, the decoded images will have the channels stored in **B G R** order.
 * -   When using IMREAD_GRAYSCALE, the codec's internal grayscale conversion will be used, if available.
 *     Results may differ to the output of cvtColor()
 * -   On Microsoft Windows\* OS and MacOSX\*, the codecs shipped with an OpenCV image (libjpeg,
 *     libpng, libtiff, and libjasper) are used by default. So, OpenCV can always read JPEGs, PNGs,
 *     and TIFFs. On MacOSX, there is also an option to use native MacOSX image readers. But beware
 *     that currently these native image loaders give images with different pixel values because of
 *     the color management embedded into MacOSX.
 * -   On Linux\*, BSD flavors and other Unix-like open-source operating systems, OpenCV looks for
 *     codecs supplied with an OS image. Install the relevant packages (do not forget the development
 *     files, for example, "libjpeg-dev", in Debian\* and Ubuntu\*) to get the codec support or turn
 *     on the OPENCV_BUILD_3RDPARTY_LIBS flag in CMake.
 * -   In the case you set *WITH_GDAL* flag to true in CMake and REF: IMREAD_LOAD_GDAL to load the image,
 *     then the [GDAL](http://www.gdal.org) driver will be used in order to decode the image, supporting
 *     the following formats: [Raster](http://www.gdal.org/formats_list.html),
 *     [Vector](http://www.gdal.org/ogr_formats.html).
 * -   If EXIF information is embedded in the image file, the EXIF orientation will be taken into account
 *     and thus the image will be rotated accordingly except if the flags REF: IMREAD_IGNORE_ORIENTATION
 *     or REF: IMREAD_UNCHANGED are passed.
 * -   Use the IMREAD_UNCHANGED flag to keep the floating point values from PFM image.
 * -   By default number of pixels must be less than 2^30. Limit can be set using system
 *     variable OPENCV_IO_MAX_IMAGE_PIXELS
 *
 * @param filename Name of file to be loaded.
 * @param flags Flag that can take values of cv::ImreadModes
 */
+ (Mat*)imread:(NSString*)filename flags:(int)flags NS_SWIFT_NAME(imread(filename:flags:));

/**
 * Loads an image from a file.
 *
 *  imread
 *
 * The function imread loads an image from the specified file and returns it. If the image cannot be
 * read (because of missing file, improper permissions, unsupported or invalid format), the function
 * returns an empty matrix ( Mat::data==NULL ).
 *
 * Currently, the following file formats are supported:
 *
 * -   Windows bitmaps - \*.bmp, \*.dib (always supported)
 * -   JPEG files - \*.jpeg, \*.jpg, \*.jpe (see the *Note* section)
 * -   JPEG 2000 files - \*.jp2 (see the *Note* section)
 * -   Portable Network Graphics - \*.png (see the *Note* section)
 * -   WebP - \*.webp (see the *Note* section)
 * -   AVIF - \*.avif (see the *Note* section)
 * -   Portable image format - \*.pbm, \*.pgm, \*.ppm \*.pxm, \*.pnm (always supported)
 * -   PFM files - \*.pfm (see the *Note* section)
 * -   Sun rasters - \*.sr, \*.ras (always supported)
 * -   TIFF files - \*.tiff, \*.tif (see the *Note* section)
 * -   OpenEXR Image files - \*.exr (see the *Note* section)
 * -   Radiance HDR - \*.hdr, \*.pic (always supported)
 * -   Raster and Vector geospatial data supported by GDAL (see the *Note* section)
 *
 * NOTE:
 * -   The function determines the type of an image by the content, not by the file extension.
 * -   In the case of color images, the decoded images will have the channels stored in **B G R** order.
 * -   When using IMREAD_GRAYSCALE, the codec's internal grayscale conversion will be used, if available.
 *     Results may differ to the output of cvtColor()
 * -   On Microsoft Windows\* OS and MacOSX\*, the codecs shipped with an OpenCV image (libjpeg,
 *     libpng, libtiff, and libjasper) are used by default. So, OpenCV can always read JPEGs, PNGs,
 *     and TIFFs. On MacOSX, there is also an option to use native MacOSX image readers. But beware
 *     that currently these native image loaders give images with different pixel values because of
 *     the color management embedded into MacOSX.
 * -   On Linux\*, BSD flavors and other Unix-like open-source operating systems, OpenCV looks for
 *     codecs supplied with an OS image. Install the relevant packages (do not forget the development
 *     files, for example, "libjpeg-dev", in Debian\* and Ubuntu\*) to get the codec support or turn
 *     on the OPENCV_BUILD_3RDPARTY_LIBS flag in CMake.
 * -   In the case you set *WITH_GDAL* flag to true in CMake and REF: IMREAD_LOAD_GDAL to load the image,
 *     then the [GDAL](http://www.gdal.org) driver will be used in order to decode the image, supporting
 *     the following formats: [Raster](http://www.gdal.org/formats_list.html),
 *     [Vector](http://www.gdal.org/ogr_formats.html).
 * -   If EXIF information is embedded in the image file, the EXIF orientation will be taken into account
 *     and thus the image will be rotated accordingly except if the flags REF: IMREAD_IGNORE_ORIENTATION
 *     or REF: IMREAD_UNCHANGED are passed.
 * -   Use the IMREAD_UNCHANGED flag to keep the floating point values from PFM image.
 * -   By default number of pixels must be less than 2^30. Limit can be set using system
 *     variable OPENCV_IO_MAX_IMAGE_PIXELS
 *
 * @param filename Name of file to be loaded.
 */
+ (Mat*)imread:(NSString*)filename NS_SWIFT_NAME(imread(filename:));


//
//  void cv::imread(String filename, Mat& dst, int flags = IMREAD_COLOR_BGR)
//
/**
 * Loads an image from a file.
 *
 * This is an overloaded member function, provided for convenience. It differs from the above function only in what argument(s) it accepts and the return value.
 * @param filename Name of file to be loaded.
 * @param dst object in which the image will be loaded.
 * @param flags Flag that can take values of cv::ImreadModes
 * NOTE:
 * The image passing through the img parameter can be pre-allocated. The memory is reused if the shape and the type match with the load image.
 */
+ (void)imread:(NSString*)filename dst:(Mat*)dst flags:(int)flags NS_SWIFT_NAME(imread(filename:dst:flags:));

/**
 * Loads an image from a file.
 *
 * This is an overloaded member function, provided for convenience. It differs from the above function only in what argument(s) it accepts and the return value.
 * @param filename Name of file to be loaded.
 * @param dst object in which the image will be loaded.
 * NOTE:
 * The image passing through the img parameter can be pre-allocated. The memory is reused if the shape and the type match with the load image.
 */
+ (void)imread:(NSString*)filename dst:(Mat*)dst NS_SWIFT_NAME(imread(filename:dst:));


//
//  bool cv::imreadmulti(String filename, vector_Mat& mats, int flags = IMREAD_ANYCOLOR)
//
/**
 * Loads a multi-page image from a file.
 *
 * The function imreadmulti loads a multi-page image from the specified file into a vector of Mat objects.
 * @param filename Name of file to be loaded.
 * @param mats A vector of Mat objects holding each page.
 * @param flags Flag that can take values of cv::ImreadModes, default with cv::IMREAD_ANYCOLOR.
 * @see `cv::imread`
 */
+ (BOOL)imreadmulti:(NSString*)filename mats:(NSMutableArray<Mat*>*)mats flags:(int)flags NS_SWIFT_NAME(imreadmulti(filename:mats:flags:));

/**
 * Loads a multi-page image from a file.
 *
 * The function imreadmulti loads a multi-page image from the specified file into a vector of Mat objects.
 * @param filename Name of file to be loaded.
 * @param mats A vector of Mat objects holding each page.
 * @see `cv::imread`
 */
+ (BOOL)imreadmulti:(NSString*)filename mats:(NSMutableArray<Mat*>*)mats NS_SWIFT_NAME(imreadmulti(filename:mats:));


//
//  bool cv::imreadmulti(String filename, vector_Mat& mats, int start, int count, int flags = IMREAD_ANYCOLOR)
//
/**
 * Loads a of images of a multi-page image from a file.
 *
 * The function imreadmulti loads a specified range from a multi-page image from the specified file into a vector of Mat objects.
 * @param filename Name of file to be loaded.
 * @param mats A vector of Mat objects holding each page.
 * @param start Start index of the image to load
 * @param count Count number of images to load
 * @param flags Flag that can take values of cv::ImreadModes, default with cv::IMREAD_ANYCOLOR.
 * @see `cv::imread`
 */
+ (BOOL)imreadmulti:(NSString*)filename mats:(NSMutableArray<Mat*>*)mats start:(int)start count:(int)count flags:(int)flags NS_SWIFT_NAME(imreadmulti(filename:mats:start:count:flags:));

/**
 * Loads a of images of a multi-page image from a file.
 *
 * The function imreadmulti loads a specified range from a multi-page image from the specified file into a vector of Mat objects.
 * @param filename Name of file to be loaded.
 * @param mats A vector of Mat objects holding each page.
 * @param start Start index of the image to load
 * @param count Count number of images to load
 * @see `cv::imread`
 */
+ (BOOL)imreadmulti:(NSString*)filename mats:(NSMutableArray<Mat*>*)mats start:(int)start count:(int)count NS_SWIFT_NAME(imreadmulti(filename:mats:start:count:));


//
//  size_t cv::imcount(String filename, int flags = IMREAD_ANYCOLOR)
//
/**
 * Returns the number of images inside the give file
 *
 * The function imcount will return the number of pages in a multi-page image, or 1 for single-page images
 * @param filename Name of file to be loaded.
 * @param flags Flag that can take values of cv::ImreadModes, default with cv::IMREAD_ANYCOLOR.
 */
+ (size_t)imcount:(NSString*)filename flags:(int)flags NS_SWIFT_NAME(imcount(filename:flags:));

/**
 * Returns the number of images inside the give file
 *
 * The function imcount will return the number of pages in a multi-page image, or 1 for single-page images
 * @param filename Name of file to be loaded.
 */
+ (size_t)imcount:(NSString*)filename NS_SWIFT_NAME(imcount(filename:));


//
//  bool cv::imwrite(String filename, Mat img, vector_int params = std::vector<int>())
//
/**
 * Saves an image to a specified file.
 *
 * The function imwrite saves the image to the specified file. The image format is chosen based on the
 * filename extension (see cv::imread for the list of extensions). In general, only 8-bit unsigned (CV_8U)
 * single-channel or 3-channel (with 'BGR' channel order) images
 * can be saved using this function, with these exceptions:
 *
 * - With OpenEXR encoder, only 32-bit float (CV_32F) images can be saved.
 *   - 8-bit unsigned (CV_8U) images are not supported.
 * - With Radiance HDR encoder, non 64-bit float (CV_64F) images can be saved.
 *   - All images will be converted to 32-bit float (CV_32F).
 * - With JPEG 2000 encoder, 8-bit unsigned (CV_8U) and 16-bit unsigned (CV_16U) images can be saved.
 * - With PAM encoder, 8-bit unsigned (CV_8U) and 16-bit unsigned (CV_16U) images can be saved.
 * - With PNG encoder, 8-bit unsigned (CV_8U) and 16-bit unsigned (CV_16U) images can be saved.
 *   - PNG images with an alpha channel can be saved using this function. To do this, create
 *     8-bit (or 16-bit) 4-channel image BGRA, where the alpha channel goes last. Fully transparent pixels
 *     should have alpha set to 0, fully opaque pixels should have alpha set to 255/65535 (see the code sample below).
 * - With PGM/PPM encoder, 8-bit unsigned (CV_8U) and 16-bit unsigned (CV_16U) images can be saved.
 * - With TIFF encoder, 8-bit unsigned (CV_8U), 16-bit unsigned (CV_16U),
 *                      32-bit float (CV_32F) and 64-bit float (CV_64F) images can be saved.
 *   - Multiple images (vector of Mat) can be saved in TIFF format (see the code sample below).
 *   - 32-bit float 3-channel (CV_32FC3) TIFF images will be saved
 *     using the LogLuv high dynamic range encoding (4 bytes per pixel)
 *
 * If the image format is not supported, the image will be converted to 8-bit unsigned (CV_8U) and saved that way.
 *
 * If the format, depth or channel order is different, use
 * Mat::convertTo and cv::cvtColor to convert it before saving. Or, use the universal FileStorage I/O
 * functions to save the image to XML or YAML format.
 *
 * The sample below shows how to create a BGRA image, how to set custom compression parameters and save it to a PNG file.
 * It also demonstrates how to save multiple images in a TIFF file:
 * INCLUDE: snippets/imgcodecs_imwrite.cpp
 * @param filename Name of the file.
 * @param img (Mat or vector of Mat) Image or Images to be saved.
 * @param params Format-specific parameters encoded as pairs (paramId_1, paramValue_1, paramId_2, paramValue_2, ... .) see cv::ImwriteFlags
 */
+ (BOOL)imwrite:(NSString*)filename img:(Mat*)img params:(IntVector*)params NS_SWIFT_NAME(imwrite(filename:img:params:));

/**
 * Saves an image to a specified file.
 *
 * The function imwrite saves the image to the specified file. The image format is chosen based on the
 * filename extension (see cv::imread for the list of extensions). In general, only 8-bit unsigned (CV_8U)
 * single-channel or 3-channel (with 'BGR' channel order) images
 * can be saved using this function, with these exceptions:
 *
 * - With OpenEXR encoder, only 32-bit float (CV_32F) images can be saved.
 *   - 8-bit unsigned (CV_8U) images are not supported.
 * - With Radiance HDR encoder, non 64-bit float (CV_64F) images can be saved.
 *   - All images will be converted to 32-bit float (CV_32F).
 * - With JPEG 2000 encoder, 8-bit unsigned (CV_8U) and 16-bit unsigned (CV_16U) images can be saved.
 * - With PAM encoder, 8-bit unsigned (CV_8U) and 16-bit unsigned (CV_16U) images can be saved.
 * - With PNG encoder, 8-bit unsigned (CV_8U) and 16-bit unsigned (CV_16U) images can be saved.
 *   - PNG images with an alpha channel can be saved using this function. To do this, create
 *     8-bit (or 16-bit) 4-channel image BGRA, where the alpha channel goes last. Fully transparent pixels
 *     should have alpha set to 0, fully opaque pixels should have alpha set to 255/65535 (see the code sample below).
 * - With PGM/PPM encoder, 8-bit unsigned (CV_8U) and 16-bit unsigned (CV_16U) images can be saved.
 * - With TIFF encoder, 8-bit unsigned (CV_8U), 16-bit unsigned (CV_16U),
 *                      32-bit float (CV_32F) and 64-bit float (CV_64F) images can be saved.
 *   - Multiple images (vector of Mat) can be saved in TIFF format (see the code sample below).
 *   - 32-bit float 3-channel (CV_32FC3) TIFF images will be saved
 *     using the LogLuv high dynamic range encoding (4 bytes per pixel)
 *
 * If the image format is not supported, the image will be converted to 8-bit unsigned (CV_8U) and saved that way.
 *
 * If the format, depth or channel order is different, use
 * Mat::convertTo and cv::cvtColor to convert it before saving. Or, use the universal FileStorage I/O
 * functions to save the image to XML or YAML format.
 *
 * The sample below shows how to create a BGRA image, how to set custom compression parameters and save it to a PNG file.
 * It also demonstrates how to save multiple images in a TIFF file:
 * INCLUDE: snippets/imgcodecs_imwrite.cpp
 * @param filename Name of the file.
 * @param img (Mat or vector of Mat) Image or Images to be saved.
 */
+ (BOOL)imwrite:(NSString*)filename img:(Mat*)img NS_SWIFT_NAME(imwrite(filename:img:));


//
//  bool cv::imwritemulti(String filename, vector_Mat img, vector_int params = std::vector<int>())
//
+ (BOOL)imwritemulti:(NSString*)filename img:(NSArray<Mat*>*)img params:(IntVector*)params NS_SWIFT_NAME(imwritemulti(filename:img:params:));

+ (BOOL)imwritemulti:(NSString*)filename img:(NSArray<Mat*>*)img NS_SWIFT_NAME(imwritemulti(filename:img:));


//
//  Mat cv::imdecode(Mat buf, int flags)
//
/**
 * Reads an image from a buffer in memory.
 *
 * The function imdecode reads an image from the specified buffer in the memory. If the buffer is too short or
 * contains invalid data, the function returns an empty matrix ( Mat::data==NULL ).
 *
 * See cv::imread for the list of supported formats and flags description.
 *
 * NOTE: In the case of color images, the decoded images will have the channels stored in **B G R** order.
 * @param buf Input array or vector of bytes.
 * @param flags The same flags as in cv::imread, see cv::ImreadModes.
 */
+ (Mat*)imdecode:(Mat*)buf flags:(int)flags NS_SWIFT_NAME(imdecode(buf:flags:));


//
//  bool cv::imdecodemulti(Mat buf, int flags, vector_Mat& mats, Range range = Range::all())
//
/**
 * Reads a multi-page image from a buffer in memory.
 *
 * The function imdecodemulti reads a multi-page image from the specified buffer in the memory. If the buffer is too short or
 * contains invalid data, the function returns false.
 *
 * See cv::imreadmulti for the list of supported formats and flags description.
 *
 * NOTE: In the case of color images, the decoded images will have the channels stored in **B G R** order.
 * @param buf Input array or vector of bytes.
 * @param flags The same flags as in cv::imread, see cv::ImreadModes.
 * @param mats A vector of Mat objects holding each page, if more than one.
 * @param range A continuous selection of pages.
 */
+ (BOOL)imdecodemulti:(Mat*)buf flags:(int)flags mats:(NSMutableArray<Mat*>*)mats range:(Range*)range NS_SWIFT_NAME(imdecodemulti(buf:flags:mats:range:));

/**
 * Reads a multi-page image from a buffer in memory.
 *
 * The function imdecodemulti reads a multi-page image from the specified buffer in the memory. If the buffer is too short or
 * contains invalid data, the function returns false.
 *
 * See cv::imreadmulti for the list of supported formats and flags description.
 *
 * NOTE: In the case of color images, the decoded images will have the channels stored in **B G R** order.
 * @param buf Input array or vector of bytes.
 * @param flags The same flags as in cv::imread, see cv::ImreadModes.
 * @param mats A vector of Mat objects holding each page, if more than one.
 */
+ (BOOL)imdecodemulti:(Mat*)buf flags:(int)flags mats:(NSMutableArray<Mat*>*)mats NS_SWIFT_NAME(imdecodemulti(buf:flags:mats:));


//
//  bool cv::imencode(String ext, Mat img, vector_uchar& buf, vector_int params = std::vector<int>())
//
/**
 * Encodes an image into a memory buffer.
 *
 * The function imencode compresses the image and stores it in the memory buffer that is resized to fit the
 * result. See cv::imwrite for the list of supported formats and flags description.
 *
 * @param ext File extension that defines the output format. Must include a leading period.
 * @param img Image to be written.
 * @param buf Output buffer resized to fit the compressed image.
 * @param params Format-specific parameters. See cv::imwrite and cv::ImwriteFlags.
 */
+ (BOOL)imencode:(NSString*)ext img:(Mat*)img buf:(ByteVector*)buf params:(IntVector*)params NS_SWIFT_NAME(imencode(ext:img:buf:params:));

/**
 * Encodes an image into a memory buffer.
 *
 * The function imencode compresses the image and stores it in the memory buffer that is resized to fit the
 * result. See cv::imwrite for the list of supported formats and flags description.
 *
 * @param ext File extension that defines the output format. Must include a leading period.
 * @param img Image to be written.
 * @param buf Output buffer resized to fit the compressed image.
 */
+ (BOOL)imencode:(NSString*)ext img:(Mat*)img buf:(ByteVector*)buf NS_SWIFT_NAME(imencode(ext:img:buf:));


//
//  bool cv::haveImageReader(String filename)
//
/**
 * Returns true if the specified image can be decoded by OpenCV
 *
 * @param filename File name of the image
 */
+ (BOOL)haveImageReader:(NSString*)filename NS_SWIFT_NAME(haveImageReader(filename:));


//
//  bool cv::haveImageWriter(String filename)
//
/**
 * Returns true if an image with the specified filename can be encoded by OpenCV
 *
 * @param filename File name of the image
 */
+ (BOOL)haveImageWriter:(NSString*)filename NS_SWIFT_NAME(haveImageWriter(filename:));



@end

NS_ASSUME_NONNULL_END


