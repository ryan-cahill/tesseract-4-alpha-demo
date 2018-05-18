#include "tesseract/baseapi.h"
#include <leptonica/allheaders.h>
#include <string>

int main() {
    tesseract::TessBaseAPI* tesseractBaseAPI = new tesseract::TessBaseAPI();
    tesseractBaseAPI -> Init("/tessdata/", "eng", tesseract::OcrEngineMode::OEM_LSTM_ONLY);

    Pix *image = pixRead("/usr/src/app/foxanddog.jpg");
    tesseractBaseAPI->SetImage(image);

    std::string outText = tesseractBaseAPI->GetUTF8Text();
    printf("OCR output:\n%s", outText.c_str());

    tesseractBaseAPI->End();
    pixDestroy(&image);

    return 0;
}