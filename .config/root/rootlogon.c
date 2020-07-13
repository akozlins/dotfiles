
void set_plot_style()
{
/*    const Int_t NRGBs = 5;
    const Int_t NCont = 99;

    Double_t stops[NRGBs] = { 0.00, 0.34, 0.61, 0.84, 1.00 };
    Double_t red[NRGBs]   = { 0.00, 0.00, 0.87, 1.00, 0.51 };
    Double_t green[NRGBs] = { 0.00, 0.81, 1.00, 0.20, 0.00 };
    Double_t blue[NRGBs]  = { 0.51, 1.00, 0.12, 0.00, 0.00 };
    TColor::CreateGradientColorTable(NRGBs, stops, red, green, blue, NCont);
    gStyle->SetNumberContours(NCont);*/

    const int NRGBs = 7, NCont = 999;
    gStyle->SetNumberContours(NCont);
    Double_t stops[NRGBs] = { 0.00, 0.10, 0.25, 0.45, 0.60, 0.75, 1.00 };
    Double_t red[NRGBs]   = { 1.00, 0.00, 0.00, 0.00, 0.97, 0.97, 0.10 };
    Double_t green[NRGBs] = { 1.00, 0.97, 0.30, 0.40, 0.97, 0.00, 0.00 };
    Double_t blue[NRGBs]  = { 1.00, 0.97, 0.97, 0.00, 0.00, 0.00, 0.00 };
    TColor::CreateGradientColorTable(NRGBs, stops, red, green, blue, NCont);
}

void rootlogon() {
    gSystem->Load("libCLHEP");

    // <https://root.cern.ch/doc/master/classTAttText.html>
    int fontNumber = 4, // helvetica-medium-r-normal - "Arial"
        fontPrecision = 2, // scalable and rotatable hardware fonts
        fontCode = 10 * fontNumber + fontPrecision;

    gStyle->SetCanvasDefW(480+4);
    gStyle->SetCanvasDefH(480+28);
    gStyle->SetCanvasDefX(0);
    gStyle->SetCanvasDefY(479);

    if(0 == strcmp(gSystem->HostName(), "gpu16")) {
        gStyle->SetCanvasDefW(640+4);
        gStyle->SetCanvasDefH(640+28);
        gStyle->SetCanvasDefX(0);
        gStyle->SetCanvasDefY(556);
    }

    gStyle->SetTitleFont(fontCode, "_");
    gStyle->SetTitleFont(fontCode, "xyz");
    gStyle->SetLabelFont(fontCode, "xyz");
    gStyle->SetLabelSize(0.035, "xyz");

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
    gStyle->SetPadRightMargin(0.12);
    gStyle->SetPadLeftMargin(0.12);
    gStyle->SetTitleXOffset(1.05);
    gStyle->SetTitleYOffset(1.15);
    gStyle->SetTitleXSize(0.05);
    gStyle->SetTitleYSize(0.05);
    gStyle->SetTitleStyle(0);
    TGaxis::SetMaxDigits(3);

    set_plot_style();

    gROOT->ForceStyle();
}
