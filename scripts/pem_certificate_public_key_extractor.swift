#!/usr/bin/swift

import Foundation
import Security

// Function to read file content from a given path
func readPEMFile(at path: String) -> String? {
    do {
        return try String(contentsOfFile: path, encoding: .utf8)
    } catch {
        print("Error: Could not read the file at path: \(path)")
        return nil
    }
}

// Function to split the PEM file into individual certificates
func extractCertificates(from pem: String) -> [String] {
    let pattern = "-----BEGIN CERTIFICATE-----(.*?)-----END CERTIFICATE-----"
    let regex = try! NSRegularExpression(pattern: pattern, options: .dotMatchesLineSeparators)
    let nsrange = NSRange(pem.startIndex..<pem.endIndex, in: pem)
    
    var certificates: [String] = []
    
    regex.enumerateMatches(in: pem, options: [], range: nsrange) { match, _, _ in
        if let matchRange = match?.range(at: 1), let range = Range(matchRange, in: pem) {
            let certificate = pem[range]
            let fullCertificate = "-----BEGIN CERTIFICATE-----\(certificate)-----END CERTIFICATE-----"
            certificates.append(fullCertificate)
        }
    }
    return certificates
}

// Function to clean and properly format the PEM data for base64 decoding
func cleanPEMData(_ pem: String) -> String {
    // Remove PEM headers, footers, and any whitespace/newlines
    return pem
        .replacingOccurrences(of: "-----BEGIN CERTIFICATE-----", with: "")
        .replacingOccurrences(of: "-----END CERTIFICATE-----", with: "")
        .components(separatedBy: .whitespacesAndNewlines)
        .joined()
}

// Function to extract the public key directly from a certificate without trust evaluation
func extractPublicKeyDirectly(from certificateData: Data) -> SecKey? {
    guard let certificate = SecCertificateCreateWithData(nil, certificateData as CFData) else {
        print("Error: Could not create certificate from data")
        return nil
    }
    
    // Directly extract the public key from the certificate using SecCertificateCopyKey
    let publicKey = SecCertificateCopyKey(certificate)
    return publicKey
}

// Function to convert the public key to PEM format string
func publicKeyToPEM(_ publicKey: SecKey) -> String? {
    var error: Unmanaged<CFError>?
    if let publicKeyData = SecKeyCopyExternalRepresentation(publicKey, &error) as Data? {
        let base64Key = publicKeyData.base64EncodedString(options: [.lineLength64Characters])
        return """
        -----BEGIN PUBLIC KEY-----
        \(base64Key)
        -----END PUBLIC KEY-----
        """
    } else {
        print("Error: Could not extract public key data - \(error!.takeRetainedValue() as Error)")
        return nil
    }
}

// MAIN
if CommandLine.arguments.count < 2 {
    print("Usage: swift extractPublicKey.swift <path_to_pem_file>")
    exit(1)
}

let pemFilePath = CommandLine.arguments[1]

// Step 1: Read the PEM file
guard let pemContent = readPEMFile(at: pemFilePath) else {
    print("Error: Failed to read the PEM file.")
    exit(1)
}

// Step 2: Extract the certificates from the PEM content
let certificates = extractCertificates(from: pemContent)

guard let firstCertificate = certificates.first else {
    print("Error: No certificates found in the PEM file.")
    exit(1)
}

// Step 3: Clean and decode the first certificate
let cleanedCert = cleanPEMData(firstCertificate)

guard let certData = Data(base64Encoded: cleanedCert) else {
    print("Error: Could not decode base64 certificate, possibly due to incorrect formatting.")
    exit(1)
}

// Step 4: Directly extract the public key from the first certificate
guard let publicKey = extractPublicKeyDirectly(from: certData) else {
    print("Error: Failed to extract the public key from the first certificate.")
    exit(1)
}

// Step 5: Convert the public key to PEM format
if let publicKeyPEM = publicKeyToPEM(publicKey) {
    print(publicKeyPEM)
} else {
    print("Error: Failed to convert the public key to PEM format.")
    exit(1)
}
