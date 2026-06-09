import type { Metadata } from "next";
import { Lexend_Deca } from "next/font/google";
import Script from "next/script";
import "./globals.css";
import SupabaseProvider from "@/lib/supabase/provider";
import CartProvider from "@/lib/cart/provider";
import ToastProvider from "@/components/toast";
import Header from "@/components/header";
import Footer from "@/components/footer";
import ChatBot from "@/components/chatbot";

const lexendDeca = Lexend_Deca({
  subsets: ["latin"],
  variable: "--font-lexend-deca",
});

export const metadata: Metadata = {
  title: "RightBrainIQ - Smart Learning Cards for Early Brain Development",
  description: "Research-backed flash cards for early brain development. Shop 80+ products across 6 categories. Interactive LMS included.",
};

export default function RootLayout({
  children,
}: Readonly<{ children: React.ReactNode }>) {
  return (
    <html lang="en" className={lexendDeca.variable}>
      <body className={lexendDeca.className}>
        <Script src="https://sdk.cashfree.com/js/v3/cashfree.js" strategy="beforeInteractive" />
        <SupabaseProvider>
          <CartProvider>
            <ToastProvider>
              <Header />
              <main className="min-h-screen pt-20">{children}</main>
              <Footer />
              <ChatBot />
            </ToastProvider>
          </CartProvider>
        </SupabaseProvider>
      </body>
    </html>
  );
}
