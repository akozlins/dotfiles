
void rootlogon() {
    gSystem->Load("libCLHEP");

    // <https://root.cern.ch/doc/master/classTAttText.html>
    int fontNumber = 4, // helvetica-medium-r-normal - "Arial"
        fontPrecision = 2, // scalable and rotatable hardware fonts
        fontCode = 10 * fontNumber + fontPrecision;

    gStyle->SetCanvasDefW(640+4);
    gStyle->SetCanvasDefH(640+28);
//    gStyle->SetCanvasDefX(0);
//    gStyle->SetCanvasDefY(0);

    gStyle->SetTitleFont(fontCode, "_");
    gStyle->SetTitleFont(fontCode, "xyz");
    gStyle->SetLabelFont(fontCode, "xyz");
    gStyle->SetLabelSize(0.045, "xyz");

    gStyle->SetStatFont(fontCode);
    gStyle->SetStatX(0.99);
    gStyle->SetStatY(0.99);
    gStyle->SetStatW(0.2);
    gStyle->SetStatH(0.2);

    gStyle->SetHistLineColor(1);
    gStyle->SetHistLineWidth(2);
    gStyle->SetFrameLineWidth(2);

//    gStyle->SetFillColor(0);
    gStyle->SetTextFont(fontCode);
    gStyle->SetLegendFont(fontCode);

    gStyle->SetPadTopMargin(0.10);
    gStyle->SetPadBottomMargin(0.12);
    gStyle->SetPadRightMargin(0.13);
    gStyle->SetPadLeftMargin(0.13);
    gStyle->SetTitleXOffset(1.05);
    gStyle->SetTitleYOffset(1.15);
    gStyle->SetTitleXSize(0.05);
    gStyle->SetTitleYSize(0.05);
    gStyle->SetTitleStyle(0);
    TGaxis::SetMaxDigits(3);

    gStyle->SetPalette(kViridis);

    gROOT->ForceStyle();
}
