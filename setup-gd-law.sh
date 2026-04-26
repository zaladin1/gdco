#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "📦 1/5: Force-installing Tailwind dependencies (ignoring strict versions)..."
npm install @astrojs/tailwind tailwindcss @tailwindcss/vite --legacy-peer-deps

echo "⚙️ 2/5: Writing configuration files..."

# Force write astro.config.mjs
cat << 'EOF' > astro.config.mjs
import { defineConfig } from 'astro/config';
import tailwind from '@astrojs/tailwind';

export default defineConfig({
  integrations: [tailwind()]
});
EOF

# Force write tailwind.config.mjs
cat << 'EOF' > tailwind.config.mjs
/** @type {import('tailwindcss').Config} */
export default {
	content: ['./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}'],
	theme: {
		extend: {},
	},
	plugins: [],
}
EOF

echo "📁 3/5: Building directory structure..."
mkdir -p src/components src/layouts src/assets

echo "🏗️ 4/5: Scaffolding layout and components..."

# 1. Create the Layout
cat << 'EOF' > src/layouts/Layout.astro
---
export interface Props {
  title: string;
}
const { title } = Astro.props;
---
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width" />
    <link rel="icon" type="image/svg+xml" href="/favicon.svg" />
    <meta name="generator" content={Astro.generator} />
    <title>{title}</title>
  </head>
  <body>
    <slot />
  </body>
</html>
EOF

# 2. Create the Header Component
cat << 'EOF' > src/components/Header.astro
<header class="py-6 flex justify-between items-center">
  <div class="font-bold text-2xl text-slate-800">GD & Co.</div>
  <button class="p-3 bg-slate-700 text-white rounded-full flex items-center justify-center">
    <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path></svg>
  </button>
</header>
EOF

# 3. Create the Hero Component
cat << 'EOF' > src/components/Hero.astro
<section class="flex flex-col md:flex-row items-center justify-between py-16 gap-10">
  <div class="text-left md:w-1/2">
    <h1 class="text-4xl md:text-5xl font-serif font-bold text-slate-900 leading-tight">Welcome to GD & Co.</h1>
    <p class="mt-6 text-slate-700 max-w-md leading-relaxed">We are a long established firm of lawyers providing Manitobans with legal advice & services for your business & personal life.</p>
  </div>
  <div class="md:w-1/2 h-72 w-full bg-blue-100/50 rounded-2xl flex items-center justify-center border-2 border-dashed border-blue-300">
    <span class="text-blue-600 font-medium">[ Replace with Welcome Mat Image ]</span>
  </div>
</section>
EOF

# 4. Create the Services Component
cat << 'EOF' > src/components/Services.astro
<section class="py-16 grid grid-cols-1 md:grid-cols-2 gap-10">
  <div class="bg-[#f5e6e1] p-8 rounded-3xl h-80 flex flex-col items-center justify-center shadow-sm">
    <h2 class="text-2xl font-serif font-bold mb-6 text-slate-900">For Individuals</h2>
    <div class="w-full flex-grow border-2 border-dashed border-[#d8bbae] rounded-xl flex items-center justify-center">
      <span class="text-[#a57b68]">[ Group Illustration ]</span>
    </div>
  </div>
  <div class="bg-[#f5e6e1] p-8 rounded-3xl h-80 flex flex-col items-center justify-center shadow-sm">
    <h2 class="text-2xl font-serif font-bold mb-6 text-slate-900">For Business</h2>
    <div class="w-full flex-grow border-2 border-dashed border-[#d8bbae] rounded-xl flex items-center justify-center">
      <span class="text-[#a57b68]">[ Business Illustration ]</span>
    </div>
  </div>
</section>
EOF

# 5. Create the About Component
cat << 'EOF' > src/components/About.astro
<section class="py-20 flex flex-col md:flex-row items-center gap-12">
  <div class="w-full md:w-1/2 h-80 bg-[#eedcd5] rounded-3xl flex items-center justify-center border-2 border-dashed border-[#d8bbae]">
    <span class="text-[#a57b68]">[ Office Illustration ]</span>
  </div>
  <div class="w-full md:w-1/2">
    <h2 class="text-3xl font-serif font-bold text-slate-900">About Us</h2>
    <p class="mt-6 text-slate-700 leading-relaxed text-sm">For close to 20 years we have been providing legal advice to local businesses and individuals locally and nationally. We provide all of our clients with cost effective, sound legal advice. From real estate and conveyancing, to estate planning, corporate and commercial, and probate/administration, our experts are on hand to help you with a range of legal issues.</p>
    <a href="#" class="inline-flex items-center mt-6 text-[#a57b68] hover:text-[#8a6352] transition-colors border-b border-[#a57b68] pb-1">
      find out more <span class="ml-2">&rarr;</span>
    </a>
  </div>
</section>
EOF

# 6. Create the Contact Component
cat << 'EOF' > src/components/Contact.astro
<section class="py-20 flex flex-col md:flex-row-reverse items-center gap-12">
  <div class="w-full md:w-1/2 h-80 bg-[#dfcdc6] rounded-3xl flex items-center justify-center border-2 border-dashed border-[#c6b0a7]">
    <span class="text-[#8a6352]">[ Storefront Illustration ]</span>
  </div>
  <div class="w-full md:w-1/2">
    <h2 class="text-3xl font-serif font-bold text-slate-900">Contact Us</h2>
    <p class="mt-6 text-slate-700 leading-relaxed text-sm">If you would like to receive further information about Ginakes, Damianakos and Company, or indeed any of the services we provide, please get in touch, and we will be in contact with you directly. Opening hours 9am to 5pm weekdays. Out of hours appointments and home visits by prior arrangement.</p>
    <a href="#" class="inline-flex items-center mt-6 text-[#a57b68] hover:text-[#8a6352] transition-colors border-b border-[#a57b68] pb-1">
      find out more <span class="ml-2">&rarr;</span>
    </a>
  </div>
</section>
EOF

# 7. Create the Footer Component
cat << 'EOF' > src/components/Footer.astro
<footer class="mt-20 pt-16 w-full">
  <div class="max-w-6xl mx-auto px-4 grid grid-cols-1 md:grid-cols-4 gap-8 mb-16">
    <div>
      <div class="font-bold text-3xl font-serif text-slate-900">GD<br/>& C</div>
    </div>
    <div>
      <h3 class="font-bold text-[#4a6b8c] mb-4">Address:</h3>
      <p class="text-sm text-slate-600 mb-4">666 Leila Avenue,<br/>Winnipeg, MB, R2V 3N7</p>
      <h3 class="font-bold text-[#4a6b8c] mb-2">Phone:</h3>
      <p class="text-sm text-slate-600">(204) 942-0396</p>
    </div>
    <div>
      <h3 class="font-bold text-[#4a6b8c] mb-4">Services</h3>
      <ul class="text-sm text-slate-600 space-y-3">
        <li><a href="#" class="hover:text-slate-900">For Business</a></li>
        <li><a href="#" class="hover:text-slate-900">For Personal</a></li>
        <li><a href="#" class="hover:text-slate-900">Business Sectors</a></li>
        <li><a href="#" class="hover:text-slate-900">News & Publication</a></li>
      </ul>
    </div>
    <div>
      <h3 class="font-bold text-[#4a6b8c] mb-4">Connect with us</h3>
      <ul class="text-sm text-slate-600 space-y-3">
        <li><a href="#" class="hover:text-slate-900">Become a Client</a></li>
        <li><a href="#" class="hover:text-slate-900">Contact Us</a></li>
        <li><a href="#" class="hover:text-slate-900">About Us</a></li>
        <li><a href="#" class="hover:text-slate-900">Our Staff</a></li>
      </ul>
    </div>
  </div>
  
  <div class="h-64 w-full bg-blue-100 flex items-center justify-center border-t-2 border-dashed border-blue-300">
    <span class="text-blue-600 font-medium">[ Replace with Cityscape/Park Illustration ]</span>
  </div>
</footer>
EOF

echo "📄 5/5: Writing main page (index.astro)..."
cat << 'EOF' > src/pages/index.astro
---
import Layout from '../layouts/Layout.astro';
import Header from '../components/Header.astro';
import Hero from '../components/Hero.astro';
import Services from '../components/Services.astro';
import About from '../components/About.astro';
import Contact from '../components/Contact.astro';
import Footer from '../components/Footer.astro';
---

<Layout title="GD & Co. | Lawyers and Notaries">
  <div class="bg-gradient-to-b from-[#e3eff6] via-[#fdf5f2] to-[#e6eff6] min-h-screen font-sans">
    <div class="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8">
      <Header />
      <main>
        <Hero />
        <Services />
        <About />
        <Contact />
      </main>
    </div>
    <Footer />
  </div>
</Layout>
EOF

echo "✨ Fixed and Rebuilt! ✨"
echo "Run 'npm run dev' to see your styled page!"